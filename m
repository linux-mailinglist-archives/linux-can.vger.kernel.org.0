Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76A31E92C
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 12:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhBRLcq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 06:32:46 -0500
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:29424
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230021AbhBRLB2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho3z+m/2rxHcxGVQ4aq/BEGCwVk+EdfaIPpD2aQV7lexjUlASzQ5idpG9Nbe8813Of8wK7MG7ZzcbVO4ogZxP6m+iz5XihBjRFetu7/itUSEnFABko5DM8gKsrzUBCnJsI79wy041YyQL1whGVfiqo93SZeJeqGzbDBOChwph2RO8gkFsG47/l83tTuru6bsgtZkCPs2n2MiR8mV/RJXeqjGB+DDZkTZ4d3t9OSmfOomfuA8r6gAAQDfq8cQ0SYViyZq8/iPUp6Sm91GhLxxry1b4FIoVOaX9g/YA96DN78xIqQVFCVi3HLSpQeIu101iI6CI9oj8lWgJW7SLhOjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADai9XHU1nDsV/mYtpzo/Ho7VtmWQ0iIsODJdRMcGaY=;
 b=S/PGuPcY2MkHaMon5N2jov4CjgT6aiTazZg1MMGpduftM4wI4EU/8nhvWBXhEFKwsckbQQknKcZkUwjp2wtfCVqYG+C2vjaziI11sRkYZai0awGNO/VeFxSw2OPIV8I+WC49qKO/bLY5TC7qbTiYTbaQCGfCmPVIZii4+11SWpClV0VnOaENokbfiomy+1Lcssl4WSYnX+1iFr3Z2Uqzq0aQ3fT5aDhTxn4sRXlFf9OZlsrTRPctqs/DT5CZ2j1QVnOBOG6E8qhxSryYW4sdJspyG1A6MWn9hafZocGvW9MclrbHHHPWqViRoH6taZhWC4Gu4R4/6N3RZ4U5nUBuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADai9XHU1nDsV/mYtpzo/Ho7VtmWQ0iIsODJdRMcGaY=;
 b=H+dhBad7eIcEAVnLSk5FZ8Pr9V2v9FO5oSIWo6WNr547Cm776f8Itsa+FYeeDXhBn76QfebH33jrN+qvkWThJu4jylmN8+EXlmp11Fv3TFfjxX6NR2puUbZX8ztFtYP2BChQievIizdUA6BsdDCjCf+s9llJgE1KFOP5+i69wQw=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2327.eurprd04.prod.outlook.com (2603:10a6:4:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 18 Feb
 2021 11:00:15 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978%4]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 11:00:15 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V3 0/3] can: flexcan: fixes for freeze mode
Date:   Thu, 18 Feb 2021 19:00:34 +0800
Message-Id: <20210218110037.16591-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0037.apcprd02.prod.outlook.com (2603:1096:3:18::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 11:00:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5adf7514-b19c-4b37-2169-08d8d3fc5eb2
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2327F4B14FE9DB10DBA5F5CAE6859@DB6PR0401MB2327.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8LlwOTsEYn27VnwzWp/cJT78KPZFbANKYEa8tdi7KdLksUzH4yQfaccuQQgH2Oeoto7/3OfadRThgamcy8TDrikyhpdcOoxnsfFbqdf+jOhy4lub1/nIPq/uR+CvT+WJMTAAGcJnrCz4DxTfQdUZ3ffQHDWyuKJvzVNxmyaDzCi88gPmYZCp4FXq3G47EI0O+2MVB6ZxsFcEAa4GTW6w4Z+nnRtQFimPMy7fUmLKj6a/RGyjMkORYmMhucEV7tq7/MQrI0tVwOBsDEl3vPjR0TxWp5PITKsKPgUw/s4mI//9bbu4nzaR0iAiJbeIJbpNLR3OZIzvEZcA98+6Rh0uxl1Mi2ieR8uVe2jOQDsG4Ix2W9RUD8IxFn372XdzNUh7g5dSqhoE5UeUQqjCwZ+PEdSTLygLej8YXTDVx4mJExYW/mkjNJvLNmiLf44WjKu9qoNbOMxeuddSGNwDqq9TC07dNJx3oOL6sPTRoIcI79DV0124npTxOidUISac96QVslgFohdLqMHX5LtR1kRPRLf2PX1kJx0uc2Mgd5O8JFaHockunLcZtCPqAdcIqHv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(66476007)(8676002)(66556008)(66946007)(52116002)(8936002)(5660300002)(6666004)(186003)(1076003)(6486002)(86362001)(69590400012)(4326008)(478600001)(2616005)(316002)(4744005)(956004)(83380400001)(6916009)(36756003)(26005)(16526019)(6512007)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5/LQGtxbPmgfQQ0HZq1nRke0xs3wxAksGJNcJK43G5rkCwsB5S7fuA163B/p?=
 =?us-ascii?Q?NoLv5OHZqkv1BSIFhwi6QhReX91FeF3CT+L5cGqGNXuwZrpSEqmASwKbNC6P?=
 =?us-ascii?Q?ieeCQtYviTPwBpd1lvRZwoaKgnOHOsXjMN+i5egmofDwF9DA6REV+ukvWLvv?=
 =?us-ascii?Q?ee63jZVVjre/Mqxltn7LGFVWXLI82CSiYS2YNrytHyKTMASJ3bhUNpu8gusm?=
 =?us-ascii?Q?oQrO0kKjAf8OPYUhnKS+kW3DQWaAHGG/uU1ZG+toeg/ywmhscLA93hPL6Sda?=
 =?us-ascii?Q?UlAmkVIkdGAmHOZNsQ6t//sKQalJM84f/RHL2WvwsXgXerEOkJgAmrlkzTg2?=
 =?us-ascii?Q?nf2lAVsqHgkF1xLmPklfSmfllBlqo5B0aFIBizcGrR63Vit2fdKl1Xr0oefb?=
 =?us-ascii?Q?py0uL4sOwwxsF8ilkhWZZPtVwCokz5OuZSmoU+7Br3LYpz9h3M8JXy31oVRc?=
 =?us-ascii?Q?h/C00IBn1z2tpj2Qt5fRqhgOl9VlAYG8X4Kj4KwqLCYxULDqBJ99j0TTwWTo?=
 =?us-ascii?Q?zk7tsH1wYTpDkeFGzfDMo/iSRvQipXTm2WaDYDhMm0uz2lwlvVMOgA05efrj?=
 =?us-ascii?Q?pIQp6uknBeXv/Vw2uOb50k0i+dH4FDLL+3nandOvbLAXHovVEMDbzFAhz3Ti?=
 =?us-ascii?Q?c99UB27Z6d/L7YOivDO9HSDxopeoLAJrU1jvIAeawgi1ehgv6UN+3DjZthLZ?=
 =?us-ascii?Q?tjJX/sk+d/mxdZMGOJ5X6bXo3/cmpkzLYSmQdM8yPhE4YrtYkfbK2mTBued4?=
 =?us-ascii?Q?PD/X7snpydk5bH38DwCU+r5xwziDj1BangmdTGZa29dKz9wVapKdQVJ1NDAQ?=
 =?us-ascii?Q?K1etJHrvOaSegn20q4ZT74kEt27qiKx6w2sveKX/gZwac+4ZQ7jCt71TlVq1?=
 =?us-ascii?Q?FahgBvlGO49M54vUKAGRHz+QqH6EN7Zr1KjPvtQiunpfgdWLYJOkSiSmuEs5?=
 =?us-ascii?Q?tpFxQm6UHAkWwm2+wtvrG14jkVun88/12wO3jo5BdIugI7OYEiOZiMPp5Eu0?=
 =?us-ascii?Q?BjiQL6JQbJmlQdcIus5+G60OC4RFtXpO4V0+JaI13e1NPBICdwkNQol+HIMe?=
 =?us-ascii?Q?X4PxRBKb6Mre2WIUuY+HRkWycnlaZ9aPNfJ4zbQuEAGY4xBkkhwrdBd+5aHa?=
 =?us-ascii?Q?iMQtvtOgSbvBRmYZesaenAW541uOSzCPc7Vt3WiA34akcqeE4dcbdmVo9gXW?=
 =?us-ascii?Q?yecSf6Vx6z6HPEKDmPpw3XlRKyjGYTK0cjXPhwTL4MWkCFL2YGJjmqsZnzxj?=
 =?us-ascii?Q?+2OG+/5IZPQX9t1KC6PytsbmFxKI5ShG9fbxC3OCobRv+nqWEtYbGoG8Zumf?=
 =?us-ascii?Q?87bDJ97vxiyS36FkLsTQq7LU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adf7514-b19c-4b37-2169-08d8d3fc5eb2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 11:00:15.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbuwF76m8XnUdO/cgpkNWxOSdqsxxN/zbUtXx02E7VWgoEWJhUUQowlIkL0+23PoWlAcgm6B6n8C5pzuPJWZIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2327
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixes for freeze mode.

---
ChangLogs:
V1->V2:
	* make use of existing functions flexcan_chip_freeze().
	* add patch #1 and #3.
V2->V3:
	* read then write MCR register.

Joakim Zhang (3):
  can: flexcan: assert FRZ bit in flexcan_chip_freeze()
  can: flexcan: enable RX FIFO after FRZ/HALT valid
  can: flexcan: invoke flexcan_chip_freeze() to enter freeze mode

 drivers/net/can/flexcan.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

-- 
2.17.1

