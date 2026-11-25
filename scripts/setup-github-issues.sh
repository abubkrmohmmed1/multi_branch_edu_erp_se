#!/usr/bin/env bash
# ==============================================================================
# Setup GitHub Labels & Issues from Product Backlog (Multi-Branch Edu ERP)
# Prerequisites: GitHub CLI (gh) installed and authenticated (`gh auth login`)
# Usage: bash scripts/setup-github-issues.sh
# ==============================================================================

set -euo pipefail

echo "Checking GitHub CLI authentication..."
gh auth status >/dev/null

echo "Creating Priority, Module, and Sprint labels..."
# Priority Labels
gh label create "priority:critical" --color "B60205" --description "Critical priority" --force
gh label create "priority:high"     --color "D93F0B" --description "High priority" --force
gh label create "priority:medium"   --color "FBCA04" --description "Medium priority" --force

# Module Labels
gh label create "module:core"      --color "5319E7" --description "Core & Multi-Branch Isolation" --force
gh label create "module:finance"   --color "0E8A16" --description "Finance & Accounting Module" --force
gh label create "module:academic"  --color "1D76DB" --description "Academic & Student Affairs Module" --force
gh label create "module:hr"        --color "006B75" --description "HR & Payroll Module" --force
gh label create "module:inventory" --color "C2E0C6" --description "Inventory & Assets Custody Module" --force

# Sprint Labels
gh label create "sprint-1" --color "EDEDED" --description "Sprint 1 (21 pts)" --force
gh label create "sprint-2" --color "EDEDED" --description "Sprint 2 (21 pts)" --force
gh label create "sprint-3" --color "EDEDED" --description "Sprint 3 (21 pts)" --force
gh label create "sprint-4" --color "EDEDED" --description "Sprint 4 (21 pts)" --force

echo "Creating Product Backlog Issues..."

# --- Sprint 1 ---
gh issue create \
  --title "[PB-01] تهيئة بنية تعدد الأفرع (Multi-Branch Isolation) ونظام الصلاحيات (RBAC)" \
  --body "**Module:** Core | **Story Points:** 8 | **Sprint:** Sprint 1\n\nتأسيس عزل البيانات على مستوى الفرع (branch_id / RLS) ونظام الصلاحيات القائم على الأدوار." \
  --label "module:core,priority:critical,sprint-1"

gh issue create \
  --title "[PB-02] بوابة القبول والتسجيل وربط الطالب بالفرع والصف الدراسي" \
  --body "**Module:** Academic | **Story Points:** 8 | **Sprint:** Sprint 1\n\n**User Story (US-ACA-01):** تسجيل بيانات الطلاب الجدد وربطهم بفرع محدد وصف دراسي مع إمكانية النقل بين الأفرع." \
  --label "module:academic,priority:high,sprint-1"

gh issue create \
  --title "[PB-03] تعريف هياكل الرسوم (Fee Structures) والخصومات والمنح" \
  --body "**Module:** Finance | **Story Points:** 5 | **Sprint:** Sprint 1\n\n**User Story (US-FIN-01):** تعريف هياكل الرسوم والخصومات والمنح لكل فرع ومرحلة دراسية." \
  --label "module:finance,priority:high,sprint-1"

# --- Sprint 2 ---
gh issue create \
  --title "[PB-04] إصدار الفواتير وتحصيل الرسوم (كلي / جزئي) وسندات القبض" \
  --body "**Module:** Finance | **Story Points:** 8 | **Sprint:** Sprint 2\n\n**User Story (US-FIN-02):** إصدار فواتير إلكترونية وتحصيل الرسوم كلياً أو جزئياً مع إصدار سندات قبض فورية." \
  --label "module:finance,priority:critical,sprint-2"

gh issue create \
  --title "[PB-05] نظام الحضور والغياب اليومي للطلاب والتنبيهات" \
  --body "**Module:** Academic | **Story Points:** 5 | **Sprint:** Sprint 2\n\n**User Story (US-ACA-02):** تسجيل الحضور والغياب اليومي للطلاب وإرسال تنبيهات تلقائية لولي الأمر." \
  --label "module:academic,priority:high,sprint-2"

gh issue create \
  --title "[PB-06] إدارة الجداول الدراسية ومنع تعارض القاعات والمعلمين" \
  --body "**Module:** Academic | **Story Points:** 8 | **Sprint:** Sprint 2\n\n**User Story (US-ACA-03):** إنشاء الجداول الدراسية الأسبوعية وتوزيع القاعات والمعلمين دون تعارضات." \
  --label "module:academic,priority:medium,sprint-2"

# --- Sprint 3 ---
gh issue create \
  --title "[PB-07] المطابقة البنكية (Bank Reconciliation) واستيراد كشوف البنك" \
  --body "**Module:** Finance | **Story Points:** 8 | **Sprint:** Sprint 3\n\n**User Story (US-FIN-03):** استيراد كشوف الحسابات البنكية وإجراء مطابقة بنكية مع سندات التحصيل." \
  --label "module:finance,priority:high,sprint-3"

gh issue create \
  --title "[PB-08] إدارة الامتحانات ورصد الدرجات وإصدار الشهادات" \
  --body "**Module:** Academic | **Story Points:** 8 | **Sprint:** Sprint 3\n\n**User Story (US-ACA-04):** رصد درجات الامتحانات الفصلية والنهائية وإصدار كشوف الدرجات والشهادات آلياً." \
  --label "module:academic,priority:high,sprint-3"

gh issue create \
  --title "[PB-09] ملفات الموظفين والعقود وسجلات الدوام عبر الأفرع" \
  --body "**Module:** HR | **Story Points:** 5 | **Sprint:** Sprint 3\n\n**User Story (US-HR-01):** إدارة ملفات الموظفين وعقودهم وتعييناتهم عبر الأفرع المختلفة." \
  --label "module:hr,priority:medium,sprint-3"

# --- Sprint 4 ---
gh issue create \
  --title "[PB-10] ترحيل الأرصدة (Balance Carry-Forward) وإغلاق السنة المالية" \
  --body "**Module:** Finance | **Story Points:** 5 | **Sprint:** Sprint 4\n\n**User Story (US-FIN-04):** ترحيل الأرصدة الدائنة والمدينة للطلاب عند إغلاق السنة المالية." \
  --label "module:finance,priority:high,sprint-4"

gh issue create \
  --title "[PB-11] احتساب مسيرات الرواتب (Payroll) والبدلات والاستقطاعات" \
  --body "**Module:** HR | **Story Points:** 8 | **Sprint:** Sprint 4\n\n**User Story (US-HR-02):** احتساب مسيرات الرواتب الشهرية تلقائياً بناءً على الحضور والإجازات والبدلات والاستقطاعات." \
  --label "module:hr,priority:high,sprint-4"

gh issue create \
  --title "[PB-12] إدارة المخازن الفرعية، صرف الكتب/الزي، وتتبع العهد" \
  --body "**Module:** Inventory | **Story Points:** 8 | **Sprint:** Sprint 4\n\n**User Stories (US-INV-01, US-INV-02):** متابعة أرصدة الكتب والزي والمستلزمات وتسجيل تسليم واسترجاع العهد الشخصية." \
  --label "module:inventory,priority:medium,sprint-4"

echo "All 12 Product Backlog issues created successfully!"
