# 3. مخططات النمذجة الموحدة (UML Diagrams)

تم تصميم جميع المخططات باستخدام لغة **Mermaid** القياسية لتعمل وتُعرض تلقائياً داخل GitHub وأدوات التوثيق الحديثة (Docs-as-Code).

---

## 3.1 مخطط حالات الاستخدام (Use Case Diagram)

يوضح المخطط التالي التفاعلات الرئيسية بين الفاعلين (Actors) والنظام، مع إبراز علاقات التضمين (`<<include>>`) والامتداد (`<<extend>>`).

```mermaid
flowchart LR
    %% Actors
    Reg["موظف القبول والتسجيل<br/>(Registrar)"]
    Acc["المحاسب المالي<br/>(Accountant)"]
    Teacher["المعلم<br/>(Teacher)"]
    HR["مسؤول الموارد البشرية<br/>(HR Officer)"]
    Store["أمين المستودع<br/>(Storekeeper)"]
    Admin["مدير النظام / الفرع<br/>(Branch Admin)"]

    subgraph ERP["نظام إدارة المؤسسات التعليمية متعددة الأفرع (Multi-Branch Edu ERP)"]
        UC1(["تسجيل وقبول طالب<br/>Enroll Student"])
        UC2(["اختيار الفرع والصف<br/>Assign Branch & Grade"])
        UC3(["إصدار فاتورة الرسوم<br/>Generate Invoice"])
        UC4(["تطبيق خصم أو منحة<br/>Apply Discount"])
        UC5(["تحصيل الرسوم كلي/جزئي<br/>Collect Payment"])
        UC6(["المطابقة البنكية<br/>Bank Reconciliation"])
        UC7(["ترحيل الأرصدة<br/>Carry-Forward Balance"])
        UC8(["رصد الحضور والدرجات<br/>Attendance & Exams"])
        UC9(["إعداد مسيرات الرواتب<br/>Process Payroll"])
        UC10(["صرف المخزون والعهد<br/>Issue Inventory & Custody"])
        UC11(["تسجيل سجل التدقيق<br/>Log Audit Trail"])
    end

    Reg --> UC1
    Acc --> UC5
    Acc --> UC6
    Acc --> UC7
    Teacher --> UC8
    HR --> UC9
    Store --> UC10
    Admin --> UC2
    Admin --> UC7

    %% Include & Extend Relationships
    UC1 -. "<<include>>" .-> UC2
    UC1 -. "<<include>>" .-> UC3
    UC4 -. "<<extend>>" .-> UC3
    UC5 -. "<<include>>" .-> UC11
    UC6 -. "<<extend>>" .-> UC5
    UC7 -. "<<include>>" .-> UC11
```

---

## 3.2 مخطط الفئات (Class Diagram)

يمثل المخطط الكيانات الأساسية للنظام في الوحدات الأربع، مع ربطها بكيان الفرع (`Branch`) لضمان عزل البيانات (Multi-Branch Isolation).

```mermaid
classDiagram
    class Branch {
        +UUID branchId
        +String code
        +String name
        +String city
        +Boolean isActive
        +getBranchSummary()
    }

    class Student {
        +UUID studentId
        +UUID branchId
        +String nationalId
        +String fullName
        +String gradeLevel
        +String status
        +enroll()
        +transferBranch(targetBranchId)
    }

    class FeeStructure {
        +UUID feeId
        +UUID branchId
        +String academicYear
        +String gradeLevel
        +Decimal tuitionAmount
        +Decimal discountRate
        +calculateNetFee()
    }

    class Invoice {
        +UUID invoiceId
        +UUID studentId
        +UUID branchId
        +Decimal totalAmount
        +Decimal paidAmount
        +Decimal remainingBalance
        +String status
        +Date dueDate
        +applyDiscount(amount)
        +carryForwardBalance()
    }

    class Payment {
        +UUID paymentId
        +UUID invoiceId
        +Decimal amount
        +String paymentMethod
        +String bankRefNo
        +Boolean isReconciled
        +DateTime paidAt
        +issueReceipt()
        +reconcileWithBank()
    }

    class Attendance {
        +UUID attendanceId
        +UUID studentId
        +UUID branchId
        +Date date
        +String status
        +markAttendance()
        +notifyGuardian()
    }

    class ExamResult {
        +UUID resultId
        +UUID studentId
        +String subjectCode
        +String term
        +Decimal score
        +String gradeLetter
        +publishResult()
    }

    class Employee {
        +UUID employeeId
        +UUID branchId
        +String fullName
        +String role
        +Decimal baseSalary
        +Date hireDate
        +calculatePayroll(month)
    }

    class InventoryItem {
        +UUID itemId
        +UUID branchId
        +String sku
        +String itemName
        +String category
        +Int quantityInStock
        +UUID custodianEmployeeId
        +issueItem(qty)
        +assignCustody(employeeId)
    }

    %% Relationships
    Branch "1" --> "0..*" Student : hosts
    Branch "1" --> "0..*" FeeStructure : defines
    Branch "1" --> "0..*" Employee : employs
    Branch "1" --> "0..*" InventoryItem : stocks
    Student "1" --> "0..*" Invoice : billed_by
    FeeStructure "1" --> "0..*" Invoice : generates
    Invoice "1" --> "0..*" Payment : settled_by
    Student "1" --> "0..*" Attendance : has
    Student "1" --> "0..*" ExamResult : earns
    Employee "1" --> "0..*" InventoryItem : holds_custody
```

---

## 3.3 مخطط النشاط (Activity Diagram)
### دورة التسجيل وتحصيل الرسوم والمطابقة البنكية

```mermaid
flowchart TD
    Start(["بداية: طلب تسجيل طالب جديد"]) --> SelectBranch["تحديد الفرع والصف الدراسي"]
    SelectBranch --> VerifyDocs{"هل المستندات<br/>مكتملة؟"}
    VerifyDocs -- "لا" --> RequestDocs["طلب استكمال المستندات"] --> VerifyDocs
    VerifyDocs -- "نعم" --> CreateStudent["إنشاء ملف الطالب وربطه بـ branch_id"]
    CreateStudent --> CalcFees["جلب هيكل الرسوم (FeeStructure)"]
    CalcFees --> HasDiscount{"هل يستحق<br/>خصم/منحة؟"}
    HasDiscount -- "نعم" --> ApplyDisc["تطبيق نسبة الخصم وحساب الصافي"]
    HasDiscount -- "لا" --> IssueInv["إصدار الفاتورة (Invoice)"]
    ApplyDisc --> IssueInv

    IssueInv --> PayChoice{"نوع السداد<br/>المطلوب؟"}
    PayChoice -- "تحصيل كلي" --> FullPay["استلام المبلغ كاملاً"]
    PayChoice -- "تحصيل جزئي / أقساط" --> PartialPay["استلام دفعة وتحديث الرصيد المتبقي"]

    FullPay --> IssueReceipt["إصدار سند قبض إلكتروني وتسجيل القيد"]
    PartialPay --> IssueReceipt

    IssueReceipt --> PayMethod{"هل الدفع<br/>تحويل/شبكة بنكية؟"}
    PayMethod -- "نقدي" --> EndCash(["نهاية: إغلاق السند في الصندوق"])
    PayMethod -- "بنكي" --> ImportBank["استيراد كشف الحساب البنكي"]
    ImportBank --> MatchRef{"هل تطابق المبلغ<br/>والمرجع البنكي؟"}
    MatchRef -- "نعم" --> MarkReconciled["تحديث حالة السند إلى: مطابق (Reconciled)"]
    MatchRef -- "لا" --> FlagDiscrepancy["تسجيل تنبيه فرق مطابقة للمراجعة المالية"]
    MarkReconciled --> EndBank(["نهاية: اعتماد الإيراد في الأستاذ العام"])
    FlagDiscrepancy --> EndBank
```

---

## 3.4 مخطط التتابع (Sequence Diagram)
### عملية تحصيل الرسوم وترحيل الرصيد (Fee Collection & Balance Carry-Forward)

```mermaid
sequenceDiagram
    autonumber
    actor Acc as المحاسب (Accountant)
    participant UI as واجهة النظام (ERP UI)
    participant Fin as خدمة المالية (FinanceService)
    participant DB as قاعدة البيانات (LedgerDB)
    participant Audit as سجل التدقيق (AuditLog)

    %% Part 1: Partial/Full Payment Collection
    Acc->>UI: إدخال بيانات التحصيل (invoiceId, amount, method)
    UI->>Fin: POST /api/v1/payments/collect
    Fin->>DB: التحقق من عزل الفرع (branch_id) وجلب الفاتورة
    DB-->>Fin: بيانات الفاتورة (totalAmount, remainingBalance)

    alt المبلغ المدفوع > الرصيد المتبقي
        Fin-->>UI: خطأ: المبلغ يتجاوز الرصيد المستحق
        UI-->>Acc: عرض رسالة تنبيه
    else المبلغ صحيح (كلي أو جزئي)
        Fin->>DB: إنشاء سجل Payment وتحديث remainingBalance
        Fin->>Audit: تسجيل العملية (User, Branch, Amount, Timestamp)
        DB-->>Fin: تأكيد الحفظ (Receipt #)
        Fin-->>UI: إرجاع سند القبض وحالة الفاتورة المحدثة
        UI-->>Acc: طباعة سند القبض الإلكتروني
    end

    %% Part 2: End-of-Year Balance Carry-Forward
    Note over Acc,Audit: نهاية السنة المالية: ترحيل الأرصدة المتبقية للعام الجديد
    Acc->>UI: تشغيل معالج ترحيل الأرصدة للفرع
    UI->>Fin: POST /api/v1/fiscal-year/carry-forward
    Fin->>DB: جلب جميع الفواتير ذات (remainingBalance != 0)
    loop لكل طالب لديه رصيد مرحّل
        Fin->>DB: إغلاق فاتورة العام المنصرم وإنشاء قيد رصيد افتتاحي للعام الجديد
        Fin->>Audit: توثيق عملية الترحيل (Carry-Forward Log)
    end
    Fin-->>UI: تقرير ملخص الأرصدة المرحلة
    UI-->>Acc: عرض التقرير النهائي واعتماد الإغلاق
```
