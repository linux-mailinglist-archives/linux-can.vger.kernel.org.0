Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C49F31E92E
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 12:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhBRLdO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 06:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhBRLUw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Feb 2021 06:20:52 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F35C0613D6
        for <linux-can@vger.kernel.org>; Thu, 18 Feb 2021 03:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHDbdANs3qLoVc4ywcjoLD3Yjmd6yM9BPIHplOUH7Byte4sIqPHqUASReByqseFeXJbN/c9CSZb4XNP8aZ52CdE8EaFC/BpYEEK0t9T9Q5RjEF11OseZSS6w/o5E3uYw5z95WuiIQ0PETJ+iCOfn1ikRzKNWaVZgkbFUTqqBlW8dw4MQ3wbV2ouWjg0NPgyOczl33lEBYITmkhtmldjrXPWYFZvCuBREd1votNJdzeegGp4LYXU5kWMa+ReEpziY2AfnfLxk2IZdfzP0onjwaMMhWFJatKS37KTky0VPvSXoAx2ZRslg3iFrHPJ9UTjhtZY89Gn/sJmRI7MmGpArWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZg1jcyLSrdosgRV5o64tXbClpPF2r6whgcTAnsvTSs=;
 b=Phf/VagSuhGtG+z8uGvVpgSvBTHnBPKaLabN9fUCESSavp03w831SH/cIoSSQgyLaRiLJHmVPSywGnwdjhQ2enR105Eq9QOXEVfV1MVC/eduzChQ+wJj+LcEy7vu+R/JfYI0u93XkuWimS/kyZYVUCUBQpnrBy6/5CdQpoXquhn7hfRQ2TxJVTUNQWLX9S13qKymo9S6pkqu41OpSwExChV3eW/6iHbkg6/8Am6lUbH0JEMnYQB+1iOKYhkLSfX+T1carElgwkt6poRY688UH0kYYvnvRdDY0xJv/vm8+S65rZzaO4omxk0O60Q9m4yCsiz608TGQdGnn+qHLFboJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZg1jcyLSrdosgRV5o64tXbClpPF2r6whgcTAnsvTSs=;
 b=YICu/cKsXcUfYJub5G5/nB8xSu61mJ/Yw4cP787qz/OolEEz4mYNeI6svMivrLy+/lTpbJT6T4Duyo3QBlrutlQ/IX6hlebumw7R4/aZZZ49vgKuUcQ5h7hgRZiPiZ2MO7McvUBjiBKahwykxjqK29yffURKai+P7/AUoKL7D98=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2327.eurprd04.prod.outlook.com (2603:10a6:4:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 18 Feb
 2021 11:00:19 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978%4]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 11:00:19 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V3 2/3] can: flexcan: enable RX FIFO after FRZ/HALT valid
Date:   Thu, 18 Feb 2021 19:00:36 +0800
Message-Id: <20210218110037.16591-3-qiangqing.zhang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0037.apcprd02.prod.outlook.com (2603:1096:3:18::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 11:00:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7b0cdae-76a1-437c-dd73-08d8d3fc6131
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB232705591F9A98F851A17ED9E6859@DB6PR0401MB2327.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5l9eCuZLv8J3N3b8ZKNqXgaxkcVjZxXryonKdMuWS7kvoxH9CHXiac9pfPui6wfx/hrOWA3ltL6bWj2HxGZ4DAugvgc7FmohlPDBjnKMCHCXm5R/jZI1BGTNqoC+J+543N5kbZUoiUjAkIEbrH42ba4Xtu3VF475/waZ0YVJHRz+zIE43sNafFdxUhUuUqBt9SxBF0EM1ZAmHaGV2KOdcjuv2ouVqfeksk6n9WyTDFsr4KrA0JR/f8yNnvoylNprB6g8R7rwu8dohA1pdLo12jmIdSUYFHXbEfQ/Y/h/+Fw0ofyhzwAlO9Hh0djZLUI6r/gHqHGp84sKhrUYvNjx7zkudiynkgo1BMrWQJsj1CIVmqJ+VpQS4GUW7ud+vc1IffbK7cGtD3btVJvH2LgZrhNi7r3smXGONH1+LPqNgEzZLujue2mvgKJMi+7hRk39hQ40LmmibtM8ILJKYyO+gZrocyzSqGcqXvxieB6rQAL5vi7ABlllpVkLau3hVoNUAJ4jiBn+qqJ+yNTHqCy8UzK5gh5c1V6azYg8NwTYBkV+h9336dnjG0M6tbNcT9OM6NZ1yHJ1+gjruww7LYvNFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(66476007)(8676002)(66556008)(66946007)(52116002)(8936002)(5660300002)(6666004)(186003)(1076003)(6486002)(86362001)(69590400012)(4326008)(478600001)(2616005)(316002)(956004)(83380400001)(6916009)(36756003)(26005)(16526019)(6512007)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P9ejqNqszrJEjKCHc3UyVUW3FwvAsfSWFTdKje/Mp9Xb2xjcQ3soYcet86UE?=
 =?us-ascii?Q?uPM9F77PI7p/I5gUsp4JEnfwO0HqAWmi4KCpCjHnuTsMJu+n2546drD6YnTU?=
 =?us-ascii?Q?wwuQZvZ64/Xk0zHc5u3ANxr3OLE/CjFiDhhywPldNHdMmB4vcTE2ZZ+uhLvP?=
 =?us-ascii?Q?08N6FAkBWejkNkmQ1Wlb9jzaPqF/ogau7fQM+JIOSztqF/8RUpVUpu3vV3gN?=
 =?us-ascii?Q?I51SgslTg4m8RqlEorye12aCneKpLTMVdxFyf7Z4o4DsbAtMvQTLwBQH7IpJ?=
 =?us-ascii?Q?hnTDVLmtyC59yy3sb1/MjavHXo9Ki0jnRYM+LGiH5KqCEhy4IJbB83StDMnr?=
 =?us-ascii?Q?xAhPYb5mCpZFrWZIRFHC1Qbo+c5Zh3876K1ZfSeUPr7h4GksObCKvEO64SYk?=
 =?us-ascii?Q?UnpRvrB3VBqUb9vkZ+iMoFKHaVwShNDBFRPVcR2Q2L/O20BjH449BxdXi6Jm?=
 =?us-ascii?Q?ZCr04m4zdQc0madRImA6l8r5qsGLPe72CnhRMsnR3suBQ5zkqbIdmAi4D1R3?=
 =?us-ascii?Q?xzdzUmX3yeiEP5CuIGfzVEv82KaS9pdJnLYNB3m951sYvRoU6ksdsXMSkLK3?=
 =?us-ascii?Q?ZqVFwYYkTnFr+tydq2GAquKUjqgVIao3lel+4eLlOCNoDCrKTNPvn3c0C0WT?=
 =?us-ascii?Q?i3vwSXeKVhPKUcFaP5lhVZeXBbBEsav+L7ImKyZT63jWBFa07DKDAFlQSWf9?=
 =?us-ascii?Q?E5Q/I8d42ejxRoFUc/oSRCJJU5VX3mUO4SgTd/IG5162K3pJeJno8Sbq3Z+h?=
 =?us-ascii?Q?WDgr9p9DnUS2zjnpaMFlRZ4zWxzkmcsyaZ7y9L9AjVSysCRrE5Jp62tCh6Dy?=
 =?us-ascii?Q?UpvIK+2zcl4v3Qj+UbBi1l5+GHsHqRaIAZeLkCQ2Kggotlo9Vo5z63r7/OHe?=
 =?us-ascii?Q?xd1io7kbCV0i5O566SJtTSpO0pjYh2ySXDmavRqQL8FyvfOCqmj3WnvJNRPq?=
 =?us-ascii?Q?0P5IDo2CYCsN5xjGXS1O3EPRfdPgUVSDyOVobT4eURWGbCe+D7VMA46ni7bz?=
 =?us-ascii?Q?iOHJPLapK4Wmqupiqxa/F0YF+4nn6UVMZdN3ZStgkbX4Ybi7fDoisyWt/SfT?=
 =?us-ascii?Q?SvGozTttPN9xjRdnG5PkyhZn795iaoJ0tkLUVqFTEPKeqA5tih/Z2JgFAqzB?=
 =?us-ascii?Q?AgoeywlCHsUrdqR+ywxVIHZ86NwJ42Q9Ty4p6MJFXGc04R9V+bzDD7kYEKsq?=
 =?us-ascii?Q?A8XQO91YRC0CqKZcIa5Tz4zXJYIDRkzmo5yi+J4nk1YXajNjMBfYIMoECeFH?=
 =?us-ascii?Q?yyGugk/+6yLPlYljfKLmC5WQAEbD3AZE3PTpuln5/hEC/q3TPw7cENJWOBxI?=
 =?us-ascii?Q?vAlMEK2cK5oAVJvDNzjMIiY+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b0cdae-76a1-437c-dd73-08d8d3fc6131
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 11:00:19.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STxC2bE1/LXsg/T9Zwyf70+CkFGLcaEdSSCJJL4idlrgqxPPAOKk0eUOPjDb7UTTyWKl7L+zommUDHApEyqmLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2327
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

RX FIFO enable failed could happen when do system reboot stress test:

[    0.303958] flexcan 5a8d0000.can: 5a8d0000.can supply xceiver not found, using dummy regulator
[    0.304281] flexcan 5a8d0000.can (unnamed net_device) (uninitialized): Could not enable RX FIFO, unsupported core
[    0.314640] flexcan 5a8d0000.can: registering netdev failed
[    0.320728] flexcan 5a8e0000.can: 5a8e0000.can supply xceiver not found, using dummy regulator
[    0.320991] flexcan 5a8e0000.can (unnamed net_device) (uninitialized): Could not enable RX FIFO, unsupported core
[    0.331360] flexcan 5a8e0000.can: registering netdev failed
[    0.337444] flexcan 5a8f0000.can: 5a8f0000.can supply xceiver not found, using dummy regulator
[    0.337716] flexcan 5a8f0000.can (unnamed net_device) (uninitialized): Could not enable RX FIFO, unsupported core
[    0.348117] flexcan 5a8f0000.can: registering netdev failed

RX FIFO should be enabled after the FRZ/HALT are valid. But the current
code enable RX FIFO and FRZ/HALT at the same time.

Fixes: e955cead03117 ("CAN: Add Flexcan CAN controller driver")
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 737e594cb12c..d6a84b7e06da 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1825,10 +1825,14 @@ static int register_flexcandev(struct net_device *dev)
 	if (err)
 		goto out_chip_disable;
 
-	/* set freeze, halt and activate FIFO, restrict register access */
+	/* set freeze, halt */
+	err = flexcan_chip_freeze(priv);
+	if (err)
+		goto out_chip_disable;
+
+	/* activate FIFO, restrict register access */
 	reg = priv->read(&regs->mcr);
-	reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
-		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
+	reg |=  FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
 	priv->write(reg, &regs->mcr);
 
 	/* Currently we only support newer versions of this core
-- 
2.17.1

