Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62531EC1F
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 17:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhBRQQL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 11:16:11 -0500
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:31975
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233150AbhBRMkI (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Feb 2021 07:40:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH9MyXan2XQcljbaJhh35AVUrVRwo0P9YWPrGPFX/pKTS83QEyS60TFozCb1Rx+qYeJFKlfOFrwBknorVOTkgBGu6IA7ZuQVmsgAvdSrKWPnU0073X5yW7/7CFfh7QCv3lOU9pe7h2g554sW8QcD7b8WVQ/aX3INDKPgtFpyYOJqwSaxMDTW6ThbTMpWdyjAmyLzhWNKTCJL2G/Qo5JVpcLrGDZxXFepP2l5S+7/UESDhqFlGctkBeVbM4fRNWK61N2HJ1CosD5BPJAkgKZeoMllwwclkG39WZ2a9CrFR5y/ubFK9EBt3t/7LY1zrZy2LZUcczOnMVl3CRV6VRh94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRXVyqGU5xYXxARufVupvQL/xnyaBdea3kmDQlh9SGA=;
 b=WIfdSeDE8onyoU01RfBOkP9mv6vuRlWS/2QbUovKdS60AOZ0mpZ72XeN+872kc5GDYb1rsnwmHkLWMLBGe3UQZEPKLGXd8dEWrCYYy2gXB70jRj31hh+7mcJ/YKS15y//osBsk7b6FNrleLei/zl7SUp2pxt+Uw1SG9rqM384zSENXC56qSzZncAdIQb/HaYvf79bK/3N5aSyCkPMF5dZmO1zUrPaTqd7isWYkLbLH+N1bWhLbtalgHuBhGXSo1LYE9xAUcBIwLsB1zGvb2wa3qQWRH2KrySuVgWF/8Z9HbyvMTdm/sDMRFlExstS9BL9+30r3c/jmgKCGMbaADb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRXVyqGU5xYXxARufVupvQL/xnyaBdea3kmDQlh9SGA=;
 b=Z4c9RMXHK04iZ8DF0y+zUSouX2vkOsAY2VGxqAYrOhbONnbOaJvQWxuMiruQUaGmDTNf+BdKj5IoW2gsAyx47oM/G/J1ylqcD0Hty7M/VlS81qKNEn20IR2605QBW4hkM5vogwOnJ74X3wTk5bTCFKjr+7moZOyUd7k/7lIL25c=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2327.eurprd04.prod.outlook.com (2603:10a6:4:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 18 Feb
 2021 11:00:17 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978%4]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 11:00:17 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V3 1/3] can: flexcan: assert FRZ bit in flexcan_chip_freeze()
Date:   Thu, 18 Feb 2021 19:00:35 +0800
Message-Id: <20210218110037.16591-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218110037.16591-1-qiangqing.zhang@nxp.com>
References: <20210218110037.16591-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0037.apcprd02.prod.outlook.com (2603:1096:3:18::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 11:00:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9071c84f-10bd-4a2f-dde0-08d8d3fc5fd1
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB232711790F61F2FE957FC369E6859@DB6PR0401MB2327.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0J2lDJVoCCeVqJs6TlnQeJlUIaGZvZbnj7BMK+MAbcG3iFJ7wK/rc3lhYPC7AtaXPIsMhwbh4CQsweOtuHroSOdgOr5DZg2mfdYtZNZx8SjvHHvFb/rnM8xWwjkgFzdsnDlQudYtbz4A6c08T/4l8gkBfUzH3irJmkUh6oDh47YQ9CaRbjDKvdNTFIBE4CUf9Af1Zk711YfwA3KK0jMZI6bDzld2q2fjAmnqpvnJH5H8sKwye/IjjfLzFaufG2P1gfJRuDQtyLz2Ml/IXmGjcagHmx/vCMkbeX2UuImCoZDuD3ZqH3nsEG12b6xQRpMVwjdKTyka8Gmi9hYusTrI5VKNDthp+UF1kic6GnLlw/PZNPABSnH+vhG8RsJ0DGwc9OT5bV3ewWTDIRdQEuyFUX4UUl/1dNx1dbiRAShVMAPftdDeSRs77sGrkBz2jHZ20oB6vUtVEJ75GU9q2PBpoE6QOzMbnpezxlaxnt8VZq2g5IrXTVlCfBISCgt7yqOJaeW96W+sXqLIv5iJF9Fi/v4vgmVafzenPVci6fZwFzIB3EVjHr/HdnqeOBPiMkea36bkaBc/0pvPOfuVK+raZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(66476007)(8676002)(66556008)(66946007)(52116002)(8936002)(5660300002)(6666004)(186003)(1076003)(6486002)(86362001)(69590400012)(4326008)(478600001)(2616005)(316002)(956004)(83380400001)(6916009)(36756003)(26005)(16526019)(6512007)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9/Fd2zDrnsBgo1MA98klx4c+zCsNjQAPjbTf1ZCd23yF307UCA7oYuQ+SA1j?=
 =?us-ascii?Q?2lI+VWuwuAJ0uwmi6RGJFtWxHbs5PAPKKd1fflGsYko7OAh72QkuoquxkLC1?=
 =?us-ascii?Q?qYrKpZvJJYG0E8/AbVWCigD/e1Z1Wg6ZzhmC5HiTc7HpqdzllMNHJ4AwbEZG?=
 =?us-ascii?Q?n4Fm63a5j5OzVfMlF3phCZB34EYqM/zecO39i3Zu7vX5s0S4OwnktskDpyz5?=
 =?us-ascii?Q?Mu4UiNyVImMadCX4bclocd/6zOOjo2FqB5SHw5lxxo0wC9DlpEFtB0rr3+md?=
 =?us-ascii?Q?5F7KWeAy/AKjv/EavMvX0KZ4Xe21+LH/suW+Gj73W+SLcYUyWFdaGCnYZ/4K?=
 =?us-ascii?Q?5kDOH0kkEERS2/qvEN/ERScpOKUCW6yG7w75X3H+u/hgLA+NDxT+BxurwRhx?=
 =?us-ascii?Q?XtOd969e8rvQkAwWKu/9KaMit0Ye+xO1FZzrpiX2FGWK5Rb79FIQ7BF+gOry?=
 =?us-ascii?Q?twkZYb4RygTo5P9xpULxJTylNtE3XIFaRAg8CG6Gr9yjVQzuqHEtR64eE7t5?=
 =?us-ascii?Q?Wae0Mv3+fQc3fhtvmdqWlQhTO1wpY1FBiv/fbtVM2e43wja/xSbQv6VkDq0x?=
 =?us-ascii?Q?E7ueqJCV4wtcpGOavfcpDwib2qbFa8AX/EshEHnCQWn/kqXm0RL40S/+Vr7l?=
 =?us-ascii?Q?Hydavnt7BK298MV+eGvdomFclOWjcuWmc6nNkI3Hxvk1gKAueVGo4u6xSBCH?=
 =?us-ascii?Q?OgC9mGRKUjpezZhw78HFpjwADeEMPQ+8miE5BsGyTqhanp0HwNlYtFAWXnIb?=
 =?us-ascii?Q?tPXDRHpIYwjg/eMo4nurKU5vDVw95GzIi3ElRHEh0rdNogEr2BdtkGCXuYN8?=
 =?us-ascii?Q?P+8z7YGoOrl+WekngOUtb9vXywq1/JF10yJpevtHO9OsX1HjiY58OETBTnUh?=
 =?us-ascii?Q?b5bfbTlgMylpHFEQ8Qvf711oVW0T5lGQXZiahxO1bLCGrCcKaG+wTg57JqTZ?=
 =?us-ascii?Q?fIYPGd7cG1xi1wQmlzgkywiaENypffBLc7Syeh2VQlqpz+YVMaSjP9bXW/Kt?=
 =?us-ascii?Q?T4PvLWEYq3gD/2tfUxDQ3hH2rOQSGa8yV6JLyPfxC4tK+4Jx3EyQ8+ZBcMT+?=
 =?us-ascii?Q?p4O+kB9o+wV4f7vM8mAf14b9zwJMukA+QFmMpXVxrEBJ2RZZ5ElzCUWZTDT7?=
 =?us-ascii?Q?Ztu/Ley/5+lW+oSTikri+c2Nz+PZ25ghvehpgHiFmDSkiR0fld6TNY7y0/t9?=
 =?us-ascii?Q?8ZxXVNMrX+Mqj+5rq2sCFSlPcauknh/qfp1UnIt5307SQDh5tzzTF9gHW1E/?=
 =?us-ascii?Q?eH02Vlm3X0cunchofiAZKwkX5qiDhPrbO3VSuNEwWIFNA76JP71W4xzSh1KT?=
 =?us-ascii?Q?vj1cDfkGACEuaMUNPvSugeeW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9071c84f-10bd-4a2f-dde0-08d8d3fc5fd1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 11:00:17.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Kuyt22MF6jJgOPkUe8WOf54r1cbPyGaFZtwFG2Fwxt2hSCjgmMFDppJ/Ekgg7MejSp9Z5VqCdGsj3PQYql9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2327
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Assert HALT bit to enter freeze mode, there is a premise that FRZ bit is
asserted. This patch asserts FRZ bit in flexcan_chip_freeze, although
the reset value is 1b'1. This is a prepare patch, later patch will
invoke flexcan_chip_freeze() to enter freeze mode, which polling freeze
mode acknowledge.

Fixes: b1aa1c7a2165b ("can: flexcan: fix transition from and to freeze mode in chip_{,un}freeze")
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 038fe1036df2..737e594cb12c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -662,7 +662,7 @@ static int flexcan_chip_freeze(struct flexcan_priv *priv)
 	u32 reg;
 
 	reg = priv->read(&regs->mcr);
-	reg |= FLEXCAN_MCR_HALT;
+	reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT;
 	priv->write(reg, &regs->mcr);
 
 	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
-- 
2.17.1

