Return-Path: <linux-can+bounces-1523-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FE97E3B7
	for <lists+linux-can@lfdr.de>; Sun, 22 Sep 2024 23:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB362810A5
	for <lists+linux-can@lfdr.de>; Sun, 22 Sep 2024 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8DD75804;
	Sun, 22 Sep 2024 21:24:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78552772A;
	Sun, 22 Sep 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727040257; cv=fail; b=ROt/LdF3KabJJ47aKgTC4KZTW92SFbAyPUaQfNXTH5GWXKtCatZgraLd7dtY6ITD1YWCArlynz7fROSM6V0krbgGtjdu6GGmcctRprCgRGLlPVSPzHgHzmQgbPqwz9uV1RolG5Ypvnpl4fLT6PjE2FjvotySgi3lWSZ+zgd4aAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727040257; c=relaxed/simple;
	bh=9xzvXPwpuDpQrn64N+EsiBZpkc/NTY5EULlqNepdhKk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TkoXoPspNvuelMCDPuhsHJA2ZbXwZ8wK3QxfIV958MJP6GosId6CCWpvtihqn2DHPUqY20B49HLzfkmlJqRoC9ailXZq6BcCKP+bFU2VWaJ/4JLDI7UN/w8Bc398GOVylf8g97QHNdQtRWUL+lLTM41ar12B3CNG0tKC0hRXZX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9Hets+Yw+Z5kCytWviwmsS3jlMtM4CNuHbGpjk72nJtdvbTvY5jaHZCqA0CCatdDb7IuxanEVCDs63lsEnWTt4cu5jijL4kKmtMB7FnZcaamrJugwM3Hx80LYk3SPIUluhGz3+1H+zDSMn3ZyUwhs81U9ub4t86K7hJwNtxpGaRzHRI9svLkSxqXoWMCgjQ7vab6Q27ezS9j/7MOO9IIXUXkGd4mMlrBoQPisFi72IFKbhnwioLgvyVlK7QdU4rA6yOzZe/5Rdu1yX12iPg5gkFiY6as4+KGmfr96UlLexUcYICnScH3mtOxMaeLVi1oOrn2ZPybCRN+Jg/6WCBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1crHv1cDhqsp9AtlYuDZPZbFgIy3TmSFE9Iq8l86kEw=;
 b=W/5mGCCiefAfhxqhI4l3je5MyGVdyZcDndYrCdcFf/LGRdOSLn6cWtbh1OhZ5PnrmbyTMVGSVtQg1Y6d4Lq4PIY/qVkX6NJQC+kF6eN+jskoI+fRJcTzT23R1Xv8npM8AnEQyTt67fGGTiR5AFkpUHe0ZJ1EaAEq5bd112BLt4MmiqZgQ3+LqfYTTcV8GoOiqba8Ut2WHGJSz3WmEH7c2f+5x2rUd0o27HRigy5TI7BDX1ljfO4pa5HidBCfc9MIz3tdUE5T1YXmfku9SEtqf+6k/UBuFI0w7vhsG+DWGy/jpaHe0AGgsBWVCqLPPdk5yFR0RtmQSBZ5jytNt1p4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30; Sun, 22 Sep
 2024 14:51:59 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.7962.029; Sun, 22 Sep 2024
 14:51:59 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	William Qiu <william.qiu@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] CAST Controller Area Network driver support
Date: Sun, 22 Sep 2024 22:51:46 +0800
Message-ID: <20240922145151.130999-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2470697f-1f22-43ed-06e3-08dcdb161c29
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|7416014|366016|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	F39acXf/OgXOBzglvsL5pyOK/XKXgkQarmZCPP79bzBvKu02bEuaaMSFjmjiuLVe3dkcYF0amAIPsIg6e+HbFzXlVsjXHEKG4+LsaUYu+FIiyyNKnIE8ZOKeNRgLg41wedEB3QTxZFvuBjsqjYiiVamGtDBbSweWr07VAEoRv1c60hCYX9tkjIivZGo1N/a7y+CgTb4Wr0zg2BUfxG1RnekHAss9NsWWLmmHBYKSVuYlcPPKxloIAT0qTmsoIZnUjw0h4v88vVVVnu1/Xfz/hutcNlpi4lOJsMnABhvFUwAJd8zaUsmFRnYR4w8hgzPb4uxi884PFpjtc11n/91zXynYzQT6OqYPKzH95XYRcthZ2caZ8s7B0uB0duMBeEmUpzSvYMSYHD5rn1UeKHdPqXW/4mECYyP5Jky05P3WXaOshc3q77X9kEOfIFpyFcT3JbHkdmi16Ir+PAgvf9MNfrxdhLoRlY/z0op2ehtA2ClCjchf+sVLS976gH63BSKnQ72mbrfBxTt8v8j1BIRXCyO448bjF9uEOE5m+8KPH4pBL0nnz0j1Vf6rxvy/LNxlRm/rN7TywOACE1YcTWgXivSHDLofYLFWQZFj6lqp38yiVN2XoEWHfK+y5/pPZghF6UdgDqYXSxMvVKsVqflTNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(7416014)(366016)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HAfcnj/DqM2RHzc4xVx8n0fg0R0yccPRtS1g37KJ9eCujdNC9w47qw6zLe0k?=
 =?us-ascii?Q?2M00s4irBvOe3XpzHTrkgPgJQO1eG46oLkB2V8dh/R3PmZsnz9/q/8YyMmIk?=
 =?us-ascii?Q?svnXFsBL7cq5H6nVDCAp7CqDA6kykR0T4XZZew/UZb4HvxyUJUKs4bTbesFW?=
 =?us-ascii?Q?fltpDBt96kYphPOS57IDN6ELkpRKP7vVOYUGlCnncmy0ziWRiKKHw4c6GoLN?=
 =?us-ascii?Q?/fb9JGs7RZqf0PnKd/NRq1kyqrkoeFpJfAPa/2KjREmH5S0vbbgURSWEa6jD?=
 =?us-ascii?Q?K3wal2bVfmr2KaOWzjqijXedQE4dh6GkiIe0ZxeMbYyWey4d1QQ6tC0Syk4+?=
 =?us-ascii?Q?bRFJdLNf3pHQwZo0fZuEiTL7Sudur2B28DKIqmayXff+4Bk3edo2NGhG4KAG?=
 =?us-ascii?Q?6Y7AA+0IT7D52UmTqSJExnAJboCwO5MzjsZZnvlbTZTkUyV0DexnstR+1Cil?=
 =?us-ascii?Q?69o4+ySWMMA/j5MFGwSDNp7LE6Ms+u5ijH8O5oqI6p+9JFGQdjA+R+LX9O+C?=
 =?us-ascii?Q?bboAIKYkpVAOnrojIjOwfqZ090Qub+Qf4YPHyK6/IPRJVeoEzZ2Ie66fJ2X9?=
 =?us-ascii?Q?GryPyEDR/Zlesf4hv+qcv4moi5DEflrAkv7/gNJ0ERc2bheRbroBrsj7C/C0?=
 =?us-ascii?Q?O7aXSyW1eiWzo1CeciW13yKUsYwklecJzWq722BaoqZGqhFgxP/l9aKGsiG1?=
 =?us-ascii?Q?EufTepoi+sToTQ1xV0l/gYdorl6DvNDIGhH6b5OL9VIFGuHYX5JfC5L46dsL?=
 =?us-ascii?Q?73RZ0LVu/Hyj28YT9zeRh483XapjoqGhQn+XUkcCYwhZvtnrL2SJ0FK9qx+U?=
 =?us-ascii?Q?dfANuvBB+1v3woH1mj6HPYBuKOzUAReDh/eVXVcSRK/BWpuSfzJpRZqKIIk5?=
 =?us-ascii?Q?3V90MUtP37wgCiKpCKA9x0E+YpLj5JqfonTdT0DmLgoBgcOCb9gnyz9BYuTq?=
 =?us-ascii?Q?P9a1JCfQQTm0xhMf7gmrdcnNJN6jRwEgl1g64+0sGUVDEec6e5IvCxvrfWyv?=
 =?us-ascii?Q?asVB4CHVhUGD90NR90SAU/0UTHM2ofkgQ3oZ4tanHBGtSVFLy0mppwfpoQ56?=
 =?us-ascii?Q?augU+QHMcljaawQ9k18POnkn23rliD3NombqCK+EwGnFprp4JeEOKNLpWxqA?=
 =?us-ascii?Q?YWTldKSF3uys13MvnFWCUm1i4n/Lfd03uA011LdAc05hCslKzfiQ78gTwhIJ?=
 =?us-ascii?Q?eYVPx56YYOxTt2VZu6/VwzZknKo+CNOpVkP9/5AMPuIDeEggKdPIZUM3XaJ2?=
 =?us-ascii?Q?kBO1MGXGHG4qOMEfUeb/y/cbwRzkM08qIcx9zOznoyLjMnpRiXpOybjFQ92/?=
 =?us-ascii?Q?/ndSodSa6R9K2dC32dFnUG8B0LVhSieMW8tUnNRHpJYTddS6pPieh2FfFZN/?=
 =?us-ascii?Q?gDDJu1Aa7xDWZejlXG2/s7ZTmKo5M3sfLP33b4i7zMzU9l+gOadx9ISMtYH1?=
 =?us-ascii?Q?yW/AcSKZvp1Juyo6RWBUD+M6LEPVKR0nl4ooiGnP3ToMdt7y4G7tnIHpPPdP?=
 =?us-ascii?Q?7eNy3bdYBjzbKHJcWlW1dAbSj9HCIBumImJ1DQFStivfVMXm/cKeTLrwqUjI?=
 =?us-ascii?Q?XI0zKlgQjtmuGmNxjVDvaegYReVBkIu5NEaPP0f7eKS76Gjc/GlSSbVzkocF?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2470697f-1f22-43ed-06e3-08dcdb161c29
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 14:51:58.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYR0iaTEiamM2TiTPqz/nL43YsTERDxl9J/ndj3HD8fzH9lhgqp6qF2ckFo4pM3qBG3M9TEzIXUVZZkFg8s1Jnq7BZRHQHk0UN2UpFiosjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145

This patchset adds support for the CAST Controller Area Network Bus
Controller (version fd-7x10N00S00) which is used in StarFive JH7110 SoC.
Note that the CAN FD license for JH7110 has expired, so JH7110 only
supports CAN CC now.

Changes since v1:
Patch 1:
- Add company information in the commit message.
Patch 2:
- Add description for the hardware.
- Move "allOf" stuff down after the property definitions.
- Rename compatible names, clock names, reset names and syscon register
  names.
- Rewrite the example.
Patch 3:
- Reorder all functions for readability.
- Simplify register definitions and register access functions.
- Improve syscon related code.
- Use clk_bulk interface.
- Enable the clocks during .ndo_open() and disable during .ndo_stop().
- Use can_put_echo_skb() and can_get_echo_skb().
- Stop the TX queue when entering .ndo_start_xmit() and restart the TX
  queue after the transmission finished.
- Simplify logic and remove redundant code.
- Improve coding style.
Patch 4:
- Update the nodes according to the new dt-bindings.

History:
v1: https://lore.kernel.org/all/20240129031239.17037-1-william.qiu@starfivetech.com/

William Qiu (4):
  dt-bindings: vendor-prefixes: Add cast vendor prefix
  dt-bindings: can: Add CAST CAN Bus Controller
  can: Add driver for CAST CAN Bus Controller
  riscv: dts: starfive: jh7110: Add CAN nodes

 .../bindings/net/can/cast,can-ctrl.yaml       | 106 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  32 +
 drivers/net/can/Kconfig                       |   7 +
 drivers/net/can/Makefile                      |   1 +
 drivers/net/can/cast_can.c                    | 936 ++++++++++++++++++
 7 files changed, 1092 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml
 create mode 100644 drivers/net/can/cast_can.c


base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.43.2


