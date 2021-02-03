Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07830D6FB
	for <lists+linux-can@lfdr.de>; Wed,  3 Feb 2021 11:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhBCKDM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Feb 2021 05:03:12 -0500
Received: from mail-vi1eur05on2048.outbound.protection.outlook.com ([40.107.21.48]:33120
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233152AbhBCKDJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 3 Feb 2021 05:03:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArBffEiKi5paudcW9J7X/ZynrFEz6tan8iaCmDvH1V7EBgxrqC5vHLy6WBgFq2opVuDs/PM0TCJ8Lj2ML+6+HQnFMqOvGv5O+nDcMSkhB70wvi9wM/zyraXv3yzz5iuqDn6MEnMRmMq7S8SOXzHfXfnmQAay6kI7uFUDfMPs1CNIOhRwtTC9ESX+H5FYIT0MD92/8Q4QzWHDjbwyttEWaO5/elwDhpMZYHO4HSlWLvb4vvExEwVEAI80d1dju8CDLVewqTUDxEtnqokh/qTWpensOqTqDwQu0ByfJe6sG+aH/jNuqzI38HC7UYT0T1ktpb0mMFp5ZZaDEO5TpTSPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6QnEDa+IH93u0VK4k19k0mwK5LyPTZ32xNuOhlRP5E=;
 b=Zb+WDbbsgUPp1Ycnx5W7N9D1mR3Rq2i9NcCCqV9HHmjWTTQe0toWZABt2N2B6bRpQWMnAH21tzMd3INfrHfC52m0ND6UTXpWeJovPGiFhkCTOoQf7vQgJqzJM7D0YJnYAViEsTPQbsF8nSMhp09AGuDKtJAI7g0cd4uWqRNWNelQW8Iw2NhgW2xJ/c5iwcUeFlpZbu0kjjRmRj/YYY2t3dJagJ/bpTHVe4aDY60hxgwp/8ftmmL6PmqfQeOsA+rPX1GB9hmZaE0KtlNB27Ods1JaXIyYSPch9j9kkBtQxP7ePfdI5Uni9bDnUqCzDyF3m+9wIBwJwbmxHsFpL+LbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6QnEDa+IH93u0VK4k19k0mwK5LyPTZ32xNuOhlRP5E=;
 b=KjzYQ1viHUFsF+c+cPvInKdSUniqiS3Hbw2TIBhix7PJOtw/4CwNjuR3NTaSJwy7CTmj2WG4Nf3tFhjcEFdY6rfwJbFRqV0HRbZ+PhsAMT7KhPSiUW1gMB2tAj03Vg3qhZfbStZf92J9oXyM8Br/+xN7S0ryiZOTuj7109zJdGk=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5193.eurprd04.prod.outlook.com (2603:10a6:10:15::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 10:02:20 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 10:02:20 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 0/3] can: flexcan: fixes for freeze mode
Date:   Wed,  3 Feb 2021 18:02:52 +0800
Message-Id: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.0 via Frontend Transport; Wed, 3 Feb 2021 10:02:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5489c7fb-f5f2-4134-768b-08d8c82acb81
X-MS-TrafficTypeDiagnostic: DB7PR04MB5193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB51931D56C840B936CCC8F52CE6B49@DB7PR04MB5193.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ifws22Otb2BRdlIw+NJH6nlaL6hsRT7lCTP1juttZ7Qp0j4221WYHSZrm3+GioBSuQu8HBfjvfKEHK2DFI2JfO4+FxBBlNDTbDlS83AEqo97ILAbPdQtLB0iTcEjypKIDNb6mtrcVNQz9dUg9g4oogfaVgKS1HBs76nl399i0ku/9JQQxhChWAovOuQyhphAjRoiOhRvPhLKcEBazZ2+PGrSaUzVqXHvTD5pqp+hhUSTRAUAaK2aLTyysgjUwgAH6ItLpujNjh9yCWlJglBK2cMrlUggCktVk3Uf+GsYYMW7mRI2Uuc+h+IQG1gfvP2Xn3nHLsxpTkGaPXbm07wuLiDKdnVwd9NLSKxepIcF6LIeD97GH11SyuXu+Sz/SwOaxvFXqu2wQ88ZAl6zwMDv/12zSiE5r5D8C8fSMuWCJguWWXUDAtMioaqGrEPmnqW23wtXPc4pZ9qjcAjqTB70ybMIcZxkV5hgahrvuC1dHT2KTeuCbTXxyTuvXZhxLfI38kBgEg3x2wbhPuV1tq/rVmEaBOW0XaFlXlnsANiqchLUsaM1B31qafkJxRVq2rEa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(66946007)(2906002)(26005)(66556008)(6666004)(2616005)(1076003)(52116002)(16526019)(36756003)(8676002)(83380400001)(66476007)(6512007)(6486002)(8936002)(4326008)(4744005)(186003)(956004)(5660300002)(69590400011)(478600001)(6506007)(316002)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cTv08o7S5Z8p9Nryc/XWFK/WxFNfsOFM40+Bbel1sYtumvCQM9F2L5Ykon7z?=
 =?us-ascii?Q?QfJdsLXjuuj1o5oiIp497fHW7AfaggOKAMwtn0TFcfMviQcQMTdbsqDIDzT4?=
 =?us-ascii?Q?5MjYPtQ1l2ZVESERSx84K5ch1tyDpd/d19hCuTP6x5pesG2b7SjGkAoaL6qr?=
 =?us-ascii?Q?4c0lJ9zGuiFQkw+D1ZrN8FQar2aqiP0rKsrOH8t9ZWl4/UtzhV9TT7XcTL/j?=
 =?us-ascii?Q?lKbWEYkdtAlSZrrRHDCKzikou3pgI3/cIz/Mj1Orx5z6G44Yn2RamX642kpy?=
 =?us-ascii?Q?V2pzPQCP6ujexAWPyjfjGxx1Q+GXUU7k2kxEaaR8X9GWlzDNs5Tj2KwRRqx/?=
 =?us-ascii?Q?MDpiL6okjfqg8NK7fYiCkU2QvXi8i9VxLmIFgcI7Z1WE3wBxSFlTFXX52LHz?=
 =?us-ascii?Q?uFD4yOY16xx4eMxHyvkGs2hpDOpUvyNm6s64v7dAr31mStm6viFRdvrNZGB0?=
 =?us-ascii?Q?x3z5XTrckPtUvxySdkNHfbEER6Gj371AVeBSGHHYyoOdCrMH/vyNxkKKcpPO?=
 =?us-ascii?Q?iDEdHHAj7F5fcWoWJwc5Tq51YJgf+OVA3kQ7KvwkEYIJu+3EYlTMFIVhzJgf?=
 =?us-ascii?Q?3YSHGokqSJtxXxRTRQTvAxCPO7XOgUtI+5Utgvgam57J6cKHd1HJo73HPp6k?=
 =?us-ascii?Q?rs3gb8A5kPcQdJiPBRn+AfqznTjoaoTufeowAZC3feKnLwNxzf6zrypKKGXF?=
 =?us-ascii?Q?+KsNZY/Wvr3nOgQ/GzxylSWhOzJrZz5mBGIdIqyItBkFzDzXdDUNi35TYVAs?=
 =?us-ascii?Q?ooc/pMT0I/ZjoYcPOblm7AtjFNzTzte0XDskNT2xwUureNR5qrFJMBXHoLbD?=
 =?us-ascii?Q?3D/fzVALNQDRzBC5uVMDksO3+As3zQUy8WHOssp8i7XacLn2v1+oH73JysQh?=
 =?us-ascii?Q?+3BcXNj7WsrbonHcn+Tclo9q1Stqfggy6MzlygtzqmuVihpbHiECGf6MgsKm?=
 =?us-ascii?Q?Ip8qIFlUrLCRImW7DxG+iVSYGaUbDdUt98hiKIpss6nTar6B0XFrmtQXu8om?=
 =?us-ascii?Q?tWTZ2LikxPl3eMTHKgIKFnjbZmQOLgzGd4krXtIcJf5i5jcUONTDjVp0CRpS?=
 =?us-ascii?Q?tQTWNbPZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5489c7fb-f5f2-4134-768b-08d8c82acb81
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:02:20.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2nNFdOzcbzKQhdpwYGPsYDofd7n69xjL9VPz415X4YK4yCtjiae06OiF2xtgkDJpqiex7YZYAZ2c75mC8wmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5193
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixes for freeze mode.

---
ChangLogs:
V1->V2:
	* make use of existing functions flexcan_chip_freeze().
	* add patch #1 and #3.

Joakim Zhang (3):
  can: flexcan: assert FRZ bit in flexcan_chip_freeze()
  can: flexcan: enable RX FIFO after FRZ/HALT valid
  can: flexcan: invoke flexcan_chip_freeze() to enter freeze mode

 drivers/net/can/flexcan.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.17.1

