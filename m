Return-Path: <linux-can+bounces-28-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB197EEE8C
	for <lists+linux-can@lfdr.de>; Fri, 17 Nov 2023 10:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA7A1C208EC
	for <lists+linux-can@lfdr.de>; Fri, 17 Nov 2023 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C0013AE1;
	Fri, 17 Nov 2023 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YhZn56Ao"
X-Original-To: linux-can@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D7D4E;
	Fri, 17 Nov 2023 01:29:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYPPGd5spEMsc99nuxvX/ApQNHqPF/HDKpQ8kCTHhbYa78zgEaApMxHoXWaSVRoovieUiDJvkZTXlklWhmtVcEG+/PTve5YWEO+VKle/j/3BjK/M8YUHtH+g34VAR9L7fQU1UUVH16yCxO2+zw/Uso5lwlIXi84ToPMTWqmELACjsBkSuCYVEgSliVi6n+dlnWhKBH32xkG9GYNcVIbVsuo5cz0cn8jfuGum/z/21+Iy2v6LnvLdMgIt/GC+x3Rh++Yw6rWLkuGj86uwxZehqtHx4KnoYTaqz1Rq6u/sPdbvUkS4z8hTpuX6WhRxVKiNhoPsHLSSXg483TOtUuF+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUbvY/iTEPP/u5JXZxOh5w++tkkmci6jPU/QqnLYQwA=;
 b=CxTZiQQv5tuEXUQiQlMjSgo4K0K1h8GOOVw9lw4mwdRoN/1DDXqhEt+2uFDxUSn2898rIqc6pElRctrnraLRR+FOVcDkhUDdf1kHZ1MQJnmtYzcBlfU8qAZEWnuB+ZouDjBhtz07LY+zFK7rMWrdiwdDDVBpT9FsfVGsh9z0G+7ZUalBSstGZ3N+XjgvhJCS2de2kw4tSLj3XlE6BfW7VfYL0jRxP4HZwdZ9GHCpQX6VPLjC337brDDM91UYPQogk6Cig4Kf9Lb7k/+znw0wOS3Y71ZfNxSaHpxnZl29mHtmrpaV9BXidjBdjpEvegCp/A6tOe3cwpFxe2GHuTo+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUbvY/iTEPP/u5JXZxOh5w++tkkmci6jPU/QqnLYQwA=;
 b=YhZn56AoRjHfqvysMExhLkWRc3RxDdh5D9CGjYUHk8P/taq3sqmsAJgK4QuLUoWQzAwio4IOQ9caMFST2aLZaow1CE0byn84Cm2DuZ2c9awgwhFcx6f/TtNKhyIjKi5eXr6zo7lDz+Z5uM0Nok7RiJCTabDyN6BsB8UGpwyYuhs=
Received: from SA0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:806:130::15)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 09:29:55 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::40) by SA0PR13CA0010.outlook.office365.com
 (2603:10b6:806:130::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.11 via Frontend
 Transport; Fri, 17 Nov 2023 09:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 09:29:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 03:29:52 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 17 Nov 2023 03:29:48 -0600
From: Srinivas Goud <srinivas.goud@amd.com>
To: <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC: <git@amd.com>, <michal.simek@xilinx.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<appana.durga.rao@xilinx.com>, <naga.sureshkumar.relli@xilinx.com>, "Srinivas
 Goud" <srinivas.goud@amd.com>
Subject: [PATCH v5 1/3] dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
Date: Fri, 17 Nov 2023 14:58:54 +0530
Message-ID: <1700213336-652-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
References: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 283d7448-f52e-417b-2cd8-08dbe74fc288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2YF6zdIUfNMcY/r7+GUO7IQKTrg4uhKnq9Vs4FGSWI56wn5dio3fmEQEpQJ+cP9eevXTEIjU2LS7NlRBwH8chg4m8+QAokHWeGxDs91qZB0gUQReLNVSrT+9jER3M0P2Ymvn4O9Ed130IleQiuG0NDc9EGDPFNsE0NtbYTzkUnX/+NNOLkHc/zD3NNtFenA+q7rOW6EFFwmufCv0lCkw08WMhT5WecEvaphlNZ9HZ65cCH73PovsVE2rrdXTSDIsz35PO73aVCMpODHT2JIcVWaBv1pmAVCJf0kztvQunkjlZXcTus1I8TAyN4ldXXdjIwMgAlpvd8SVVH3aQ86ZdbPpLsZS2M9Z2md0377cAb/JJbB4quvnJ0+qjW9iBfGaqmtQCtWNl5F73zdhE2BI/ehWYPBUI0+j1gXCBiinKjpse3QlqzQ2wprx+0md3e5UpYSlFwe7ZFgBtT4MzsP2OFvdq09HOdUgP7YYpqkvSQe15H1md2+WQhzAbe1hgwcUGth/y6MQgjUZr4oXA3NszHAlm0xxwUZwFiNlWwEI5onu9Mlxl8/gPsLQnquabtZbLpLB9TTPvwiMESH1Z965mbJKH1L6sgejnIrTE54vc4IJ9QWFZYks4VlLJJRlGFHm9/33loYZtl7vSoS62UpjpZjc2Cf5POHn8xhLnfCym2jFW1WRQ+f1hvFYahu5bzdSebPbruccSKKa+hh3f4sKOWq2Xu3tFx5QbQ6m3hjJrylE5VTtXhTQzauQuKJTP/4swxTBWXPQHOL90wWUjRO1XwMa43AJUtRA6Pl9G1s0IOXFMEoUkC8s8dFJZ10sVLKCAtfalzVFN3VM2FoAj0wzZg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(2906002)(81166007)(356005)(86362001)(82740400003)(36860700001)(47076005)(7416002)(5660300002)(44832011)(40480700001)(4326008)(8936002)(41300700001)(8676002)(83380400001)(336012)(426003)(2616005)(36756003)(54906003)(316002)(26005)(70206006)(70586007)(110136005)(40460700003)(6666004)(478600001)(921008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 09:29:55.4569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283d7448-f52e-417b-2cd8-08dbe74fc288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882

ECC feature added to CAN TX_OL, TX_TL and RX FIFOs of
Xilinx AXI CAN Controller.
Part of this feature configuration and counter registers added in
IP for 1bit/2bit ECC errors.

'xlnx,has-ecc' is optional property and added to Xilinx AXI CAN Controller
node if ECC block enabled in the HW

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
Changes in v5:
Update property description

Changes in v4:
Fix binding check warning
Update property description

Changes in v3:
Update commit description
 
Changes in v2:
None

 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 64d57c3..8d4e5af 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -49,6 +49,10 @@ properties:
   resets:
     maxItems: 1
 
+  xlnx,has-ecc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: CAN TX_OL, TX_TL and RX FIFOs have ECC support(AXI CAN)
+
 required:
   - compatible
   - reg
@@ -137,6 +141,7 @@ examples:
         interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
         tx-fifo-depth = <0x40>;
         rx-fifo-depth = <0x40>;
+        xlnx,has-ecc;
     };
 
   - |
-- 
2.1.1


