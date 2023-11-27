Return-Path: <linux-can+bounces-59-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AAD7F9D7C
	for <lists+linux-can@lfdr.de>; Mon, 27 Nov 2023 11:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727E01C20AE5
	for <lists+linux-can@lfdr.de>; Mon, 27 Nov 2023 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870C018B06;
	Mon, 27 Nov 2023 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNN0liUf"
X-Original-To: linux-can@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375210F;
	Mon, 27 Nov 2023 02:28:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtThkhYfzqBEuSnasXUFtUIi7v0sCdtlLhuTE/+fXJg6Gcd6Dv0l68GJVHuPPV/nmFUqJbgajuNM9GjEuiywoGYzPF/FO50xhjyjfQ4bFDRJY3iVUpv/Czx0cHSMHViyMJc2WcSsY3FpeSBiypuOjlZgRzNUCC/QuaGkLeDCp3WVU10fhtBljtUIh3AwDDCYqFcAZBvlRd4XQMh1TP5HddARKu3GnicG6QhvNdjfheQTu3HsrL9t2ijQ6bZrH8hYN1/GKSQ1ougB++AkwxhhMY5L6Hkxkwju6L1tgVS4tqF0V5tUph62NU/UzcnD2mIzRbC5T8mbIh5T7sOAKYEDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/B75o/gAqrLgfo4nVzMOym43vouk2IbKJGE1cDl2kA=;
 b=H/cn+sZ0IEcKjyRB/xprFyGWIsdJoSdTKNJvltJi56NTHFM5rMxir9xguXA9VHyXi/h3O4VmJ5dNRpirkQoTaywLW/neEroL+WOJu7aNs85BfoWUkmCmwuflWpBBZqSNp5fLNg/QD7uXnU6fwfC5K1pzR+CTskIi28bqxt/UyLNnJiYEHDnkJOtVF5Ds9KofbjO2xeNGEMU4jowygDGYCcPI3SEAvRuuXnThBFlgGvOQ+V8ULpoefGxm3k8db67UhzBNBFzjLQusvd3SSVjej1tBBBSr+8U2OgZ1eNWFiXGpWKudp55o5746kt74TNR5qg2/KQ0JhjydO90HaY0uew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/B75o/gAqrLgfo4nVzMOym43vouk2IbKJGE1cDl2kA=;
 b=iNN0liUf9feQZTnzmg/U3NgHNSfPXWbOjn7dKVG6oVMuQf9QDTg2Ms1Ioc2O0wJFnERseXwKs0h78IDrpcRWcbH/AY0t8c6PeGbwaOexLIBfO6cdbJnECcUkycPttIpRVqSVEdrwjwDsPJvMLbGYS4Q03Dv+D8JLbqPPcn8k2zo=
Received: from PH7PR13CA0017.namprd13.prod.outlook.com (2603:10b6:510:174::13)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 10:28:37 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::d4) by PH7PR13CA0017.outlook.office365.com
 (2603:10b6:510:174::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Mon, 27 Nov 2023 10:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 10:28:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 04:28:32 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 27 Nov 2023 04:28:20 -0600
From: Srinivas Goud <srinivas.goud@amd.com>
To: <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC: <git@amd.com>, <michal.simek@xilinx.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<appana.durga.rao@xilinx.com>, Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v7 0/3] can: xilinx_can: Add ECC feature support
Date: Mon, 27 Nov 2023 15:58:12 +0530
Message-ID: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1f8f06-16e8-40fd-b100-08dbef339d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P2UPd99T/g7cR4F4g1JwnHKD78sAUoxOVaNHEx26gJLDQxm0hIFLiJiD8NSw8LYRBPcf6R9G7YneyM9Qq+7O9Gc93iKbwF+Gko7D0wZ21vsUq9GFHN3qG1lXfAK9e9K3sq9QSUDv7ncEKUycgYXowD7NErO2hIiXaKHQBsanb9HN1p5h21IWFs42xvcXIFC1F80bJfxBOuFq9yoBwoE8W5LeeRVeLDPzKckEbN6CFoUi3tsDxPYeyum3QX41ot2lEM2SYQAFh9UHjQBIdaQKHm7d2hA1vB5XUE4gNAbd4ARn7EzdvGNvH4s841wgx3SLsMIOhuuQJyjerFi9oH947WQPy25AqPcpEjnE5u9ojf++3Pmm0QFUxl1pL2xnyUYRrvBADHubOVsibCx5EbmU4Dc3KfLSV66N52/ujfXVnB2gktUST+p2zG2fbkQ7/QF5ehY8+46o7xRAhty902dO8lou+TtzpfaQ+sWXcx4tRGmoYiMYFkMlbw6/lDmNtY/fFO6wjnaYgvT9Z9Gn+gMjNDIh2eKILwvW3JVmIcaec1jU6K5f4jfA4LK1H3qvRpfH9bWB7AgY1rVW7izBBsjeGB8SjxB+sxhqSfGlh3o3A9f4yNqHZQWpZpuC3Of+akcVaSDFRRKBgQUbdRBIqsP9aSGMf2MnCguWlYcxhAGg2EhfgKIJYyQ1qBoiRFo/714fXlVhxFWAa+HGX7bIsxr5X56XZRb5M3UlIZ2RUr6/8Qbq3CSZxCnSKUzHAmBfanKEnn1RqldUup2ETI+8QkXXMyyOF49ay8Tt3jHnBKV2Xb2YW3mwB/Mjmuv/RaAZ7MBffGhVuXAXil44hchALj7l4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(36756003)(921008)(81166007)(36860700001)(47076005)(356005)(2906002)(336012)(83380400001)(426003)(7416002)(5660300002)(82740400003)(70206006)(26005)(44832011)(86362001)(2616005)(70586007)(6666004)(8676002)(8936002)(4326008)(478600001)(40460700003)(110136005)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 10:28:36.6604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1f8f06-16e8-40fd-b100-08dbef339d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705

Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller.
ECC is an IP configuration option where counter registers are added in
IP for 1bit/2bit ECC errors count and reset.
Also driver reports 1bit/2bit ECC errors for FIFOs based on ECC error
interrupts.

Add xlnx,has-ecc optional property for Xilinx AXI CAN controller
to support ECC if the ECC block is enabled in the HW.

Add ethtool stats interface for getting all the ECC errors information.

There is no public documentation for it available.

---
BRANCH: linux-can-next/master

Changes in v7:
Update with spinlock only for stats counters

Changes in v6:
Update commit description

Changes in v5:
Fix review comments
Change the sequence of updates the stats
Add get_strings and get_sset_count stats interface
Use u64 stats helper function

Changes in v4:
Fix DT binding check warning
Update xlnx,has-ecc property description

Changes in v3:
Update mailing list
Update commit description

Changes in v2:
Address review comments
Add ethtool stats interface
Update commit description


Srinivas Goud (3):
  dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
  can: xilinx_can: Add ECC support
  can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 159 ++++++++++++++++++++-
 2 files changed, 160 insertions(+), 4 deletions(-)

-- 
2.1.1


