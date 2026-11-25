# نظام إدارة المؤسسات التعليمية متعددة الأفرع (Multi-Branch Educational ERP System)

[![Docs-as-Code](https://img.shields.io/badge/Docs--as--Code-Markdown%20%2B%20Mermaid-blue)](#)
[![Methodology](https://img.shields.io/badge/Methodology-Agile%20(Scrum)-green)](#)
[![GitFlow](https://img.shields.io/badge/Workflow-GitFlow%20%2B%20Conventional%20Commits-orange)](#)
[![Ethics](https://img.shields.io/badge/Ethics-ACM%2FIEEE%20Code-purple)](#)

## نظرة عامة على النظام (System Overview)

يمثل هذا المستودع مشروع التوثيق الهندسي (Docs-as-Code) لنظام **إدارة المؤسسات التعليمية متعددة الأفرع (Multi-Branch Educational ERP System)**، وهو نظام مؤسسي متكامل (Enterprise Resource Planning) مصمم لتوحيد وإدارة العمليات الإدارية والأكاديمية والمالية للمدارس والمعاهد والمؤسسات التعليمية التي تمتلك عدة أفرع جغرافية، مع ضمان **عزل البيانات (Tenant/Branch Isolation)** على مستوى الفرع، وتوفير تقارير مركزية موحدة للإدارة العليا.

### الوحدات الأساسية للنظام (Core Modules)

1. **الإدارة المالية والمحاسبية (Finance & Accounting Module):**
   - هيكلة الرسوم الدراسية (Fee Structures) والخطط المالية لكل فرع ومرحلة.
   - إدارة الخصومات والمنح الدراسية (Discounts & Scholarships).
   - إصدار الفواتير (Invoicing)، التحصيل الكلي والجزئي (Full & Partial Payments)، وإدارة الأقساط.
   - المطابقة البنكية (Bank Reconciliation) وترحيل الأرصدة (Balance Carry-Forward / Closing) بين الفصول والسنوات الدراسية.
2. **الإدارة الأكاديمية وشؤون الطلاب (Academic & Student Affairs Module):**
   - القبول والتسجيل الإلكتروني (Admissions & Enrollment) ونقل الطلاب بين الأفرع.
   - تسجيل الحضور والغياب اليومي (Attendance Tracking).
   - بناء الجداول الدراسية (Timetabling) وإدارة القاعات والمعلمين.
   - إدارة الامتحانات والدرجات وإصدار الشهادات الأكاديمية (Exams & Grading).
3. **إدارة الموظفين والرواتب (HR & Payroll Module):**
   - ملفات الموظفين، العقود، والهيكل التنظيمي متعدد الأفرع.
   - الحضور والانصراف، الإجازات، ومسيرات الرواتب (Payroll) والبدلات والاستقطاعات.
4. **إدارة المخازن والعهد (Inventory & Assets Custody Module):**
   - إدارة المستودعات المركزية والفرعية، الكتب، والزي المدرسي، والمستلزمات.
   - تتبع العهد الشخصية للأجهزة والمعدات (Asset Custody) وعمليات الجرد والصرف.

---

## هيكل المستودع (Repository Structure)

```text
multi_branch_edu_erp_se/
├── README.md                        # نظرة عامة على النظام، الهيكل، والروابط السريعة
├── FINAL_REPORT.md                  # التقرير النهائي التجميعي (جاهز للتصدير إلى PDF)
├── docs/
│   ├── 01-software-process.md       # نماذج دورة حياة البرمجيات (Waterfall vs Agile) ومراحل النظام الـ 6
│   ├── 02-agile-planning.md         # قصص المستخدمين، Product Backlog، وخطة 4 Sprints
│   ├── 03-uml-diagrams.md           # مخططات UML كاملة بصيغة Mermaid
│   ├── 04-software-management.md    # استراتيجية GitFlow، Conventional Commits، وKanban Board
│   └── 05-ethics.md                 # أخلاقيات هندسة البرمجيات وفق ميثاق ACM/IEEE
└── scripts/
    └── setup-github-issues.sh       # سكربت أتمتة إنشاء GitHub Issues من الـ Product Backlog
```

---

## روابط سريعة للأقسام (Quick Links)

| القسم | الوصف | الرابط |
| :--- | :--- | :--- |
| **1. هندسة العمليات البرمجية** | مقارنة Waterfall وAgile، مبررات Scrum، ومراحل التطوير الـ 6 | [docs/01-software-process.md](./docs/01-software-process.md) |
| **2. التخطيط الرشيق (Agile)** | User Stories للوحدات الـ 4، Product Backlog، وخطة 4 Sprints | [docs/02-agile-planning.md](./docs/02-agile-planning.md) |
| **3. مخططات UML** | Use Case, Class, Activity, Sequence بصيغة Mermaid | [docs/03-uml-diagrams.md](./docs/03-uml-diagrams.md) |
| **4. إدارة البرمجيات** | GitFlow، Conventional Commits، وإدارة المهام عبر Kanban | [docs/04-software-management.md](./docs/04-software-management.md) |
| **5. أخلاقيات المهنة** | تطبيق ميثاق ACM/IEEE: الخصوصية، Audit Logs، الملكية الفكرية | [docs/05-ethics.md](./docs/05-ethics.md) |
| **التقرير النهائي الشامل** | ملف موحد يضم كافة الأقسام مع صفحة غلاف أكاديمية | [FINAL_REPORT.md](./FINAL_REPORT.md) |
| **أتمتة GitHub Issues** | أوامر `gh issue create` لتحويل Backlog إلى Issues | [scripts/setup-github-issues.sh](./scripts/setup-github-issues.sh) |
