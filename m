Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B28730D6FC
	for <lists+linux-can@lfdr.de>; Wed,  3 Feb 2021 11:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhBCKDO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Feb 2021 05:03:14 -0500
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:45805
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233365AbhBCKDL (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 3 Feb 2021 05:03:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwq/vig7syMo2T/+5XqRe/ArcK43q9t7/t16g1LGApqPuXbHLZAVXQH7lu3jZSKtFBVhKEQeZbHxjW6RDTRsrLYhM8RzfhxDqLSNivozHdZOKXWfeJ0VnGBs1EBlg5acvw/2FhUQeTRIt96Gp2SXzAU0J1fChdaNXKsYvNHzq3XMzlmlRLQUNM/9j5ooJkb3i1y5dRtfhZhP/4v21ISOCBnJUOdfHdGyxF1XcAKT2Or2xq6Rkel00GF3xB4/yiVqnkXZpMOpARWbzd00cPZyUR/C0pZIW/WiJXjqjJcczxRZsXGZfYFKadQBWV45BLmVlkfp6MRvuoRhNy+9skX3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRXVyqGU5xYXxARufVupvQL/xnyaBdea3kmDQlh9SGA=;
 b=b34Ylh78vKGfE5hAq2svzmH22oyRq2MOvKqdlrvIjVnMTl4POGlbdypUk0mCckUN7OXOL4dThZGbFsF4Dqvt2a2lRWf5I863Ugb7zzhgsebR2UU6QNBuo2+N8WZA/85mxOxXkth5n+/5G5gv+6CgTmbDowniIyJkACy9jx52d65ijDuw5TJq1IZUni2dq5fgTrqbyVKLfJvwrRPjaSVC3jnIYuxE89yXxnDfahXgrPF73xk4PifA6oUbL04wcZoWfN16t8eS9yXmSX0Tkg3rT6wUwz1nzotAaUcq2TFpu4QG7NIT+QSLtkXZOtvlxwJPEf5V2GZgSE9xbnZ+DPhxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRXVyqGU5xYXxARufVupvQL/xnyaBdea3kmDQlh9SGA=;
 b=eiGiGaUGdqVAtrx50C3Q1JliWxKf43PzYcBWAMIVg+qDNE+kOddzBM0nk/b3i8XjWqU8FUGMe/mtr4PH8Ax6VtbN9toGffC4jE5uZwxscCBVqzGRsS4K4Fj8VUX6Yizd7eseQzKXdXvCK7DfKukXBcpYldYqjAAjMMIcD6B0fKo=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (10.255.185.79) by
 DBAPR04MB7429.eurprd04.prod.outlook.com (20.181.184.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Wed, 3 Feb 2021 10:02:22 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 10:02:22 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 1/3] can: flexcan: assert FRZ bit in flexcan_chip_freeze()
Date:   Wed,  3 Feb 2021 18:02:53 +0800
Message-Id: <20210203100255.12472-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
References: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.0 via Frontend Transport; Wed, 3 Feb 2021 10:02:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7051078e-468a-465f-d212-08d8c82acca6
X-MS-TrafficTypeDiagnostic: DBAPR04MB7429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB74296A55B9CA4F702E52309DE6B49@DBAPR04MB7429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pj0Yg4h1jHYbOZjvQYjrXxYlzHAVQs3gKgTfwLZw2L2Vopi4RRFMnyhMU2J2Dq8PHD7QEeD2GEa1R7NxNny4sknTVT4G7f9o5HwNvHq6iF6N2HATxLW6NnnG/05xJql7J+f8XXk1EJpX3J3sgxqUvCsUG2hJ8Z8HUyEZiq2aZVGXu1yMVZPKlCcdfl2Xm1egthGoKqvj6Rgh4NT/kckjDKl4anh8KFkFYjMMHcvHeYYXWBgWKSwAwgC6g3i9fPP5f37+MOKNQ3NIJOmKYTo6rECpdMuMX5eVsoC7OfjTbImY2jsBhqTBZoUuTR4WdZcBnzkf6KawDQ/hPuNjPbNcF6wO+TtH6RV6nwisIYq+Nml1di9FaXYeSKAHzb/7m8vSDz56unvTBqNIlX5MgLhJo958dXK66TDatvpnIHoTZ+dlBlHqNeiYQVj/aP+LvXyhai9csEda89Mp5haxdEz+p6PlyLTBFJDcbfjtXjxoQG5PQRirfi1Gp2nGV5cLJ0eTd6vExvBIeh5GOsK72XzMI3UVcYxxL4a8TCXVD51L+Oxa1nHLh9OSzPo1C3gy7gdL7Lec8fT2vP4SVp+dUJQHrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(86362001)(66476007)(8936002)(478600001)(2906002)(4326008)(66556008)(52116002)(66946007)(316002)(1076003)(956004)(36756003)(8676002)(26005)(83380400001)(6506007)(16526019)(69590400011)(186003)(5660300002)(6666004)(6916009)(6486002)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dmz1hnvA8x8ZD9fSXSKblzr/7olTUeNGT6cJMGCfoS9lP/LUsL49kur8TQUw?=
 =?us-ascii?Q?CwL6w5vP3QIIMpIIMZZ6Pqvqa3aVhsowA64lcu+undngXLJOYjJG1u2dHfuy?=
 =?us-ascii?Q?6nEyocZBCjrQlyebUYhVnQ8kmY7rnmAE5c2Zhd9lyrQ2+MqQBKAZMbfjCFGe?=
 =?us-ascii?Q?7DbQlyE3dZkfsuL4nxqWLlzForB5T7zMC36CFiE2dtfsLggUTUU+/vepG6IS?=
 =?us-ascii?Q?drjlasCwqMyqh+GAgP/mynLeyBmKHhAl93tPB5DC4UQ60ZJis54dk7q4J9vt?=
 =?us-ascii?Q?JghvdVxbc+Yv8Xb0B4RP3OHCPVvCsEpu4njf1qMujvKNzX81JiUD319xCTuU?=
 =?us-ascii?Q?0XfMGUVjmWE7cpYElLfLT3G3OO3hncYMe+GnnYCjAEh96PuG7us6Bojf2Rb6?=
 =?us-ascii?Q?qO5YMDzr8GJdbbS0ZaLtl0US7qbkH0X/iorjP/c186YMm/S/w3sFJPhqNA4a?=
 =?us-ascii?Q?NzsF2PqeSjgMq3iLWONt/gfxPm91YZ5Ah0GN+dL+mILIdC7l76vXGSMNWHRq?=
 =?us-ascii?Q?BVk4i1ta8xf4OFLJArTH3onUjcSdt/1h2Qmgx++wlCXDSlH79CilN4tfKf6q?=
 =?us-ascii?Q?Vi+QBLxQK5fT/O9a4rNIBHGRjW9NHpsgFbrICVzhCBNXxLqunoFBCG8Ynb0I?=
 =?us-ascii?Q?1SJQpa5y9ZaK1t7fiMfcy24jOg8xefPVmzv4wnQY9LJKXKh2Vaz89KzmHd7n?=
 =?us-ascii?Q?Qi55i+X2v4BV2rVjtDbIFAyo/cGGf6u+wj3QLn/0VU4E+WzkXvGGarg/G2jp?=
 =?us-ascii?Q?enKuo6L6APk9K4U71gs1C3krZ4/xnLqhFDQGEAZLg3kaj1EUXNClEpNiUclO?=
 =?us-ascii?Q?b4ehFCTv78w+hAUaLqtKVb7Y6yDtUWMI4oQLUP7z1VMet8OjQD5ZSl0ZISvQ?=
 =?us-ascii?Q?DhpiCaQjySFf5+ikXvikYvAqZjB4BHOe4UdphU5oNYT4a0EBzAxPSjqwgc7X?=
 =?us-ascii?Q?xxxVH+ZimVB556+ycbrfFXhQkJ3F527YgblTKm/4O9vivsfXMsJxsKVw9U4b?=
 =?us-ascii?Q?COsSCBc0uTu3sYn1ggALxMj2ptcITs+GWOZSAglvvWqbzfFD30WIZp73/4i8?=
 =?us-ascii?Q?D1Ied9Jx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7051078e-468a-465f-d212-08d8c82acca6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:02:22.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N04MuHkvSueORM5/8x0i7d1aFrA2RPEjk9BgnMlmysqKfGfkAgc8ljVCQR2mpxjzQrW8IrA+/P4SUk1CnCCMlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7429
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

