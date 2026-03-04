Return-Path: <linux-can+bounces-6896-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G7BGJt0qGm5ugAAu9opvQ
	(envelope-from <linux-can+bounces-6896-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:06:19 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A117205BB8
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87A773031D9B
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C653E3DEAD2;
	Wed,  4 Mar 2026 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T1qCjqNJ"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B463DA5C5;
	Wed,  4 Mar 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647235; cv=fail; b=gUGdAMME70fo3p9101Lgw0Gzhcsv6WroeIW6TiPwu8J5zoaiW0eMUVWEuOJnCCiT5s2JmWU8Ai7aOVUehEhbN20Dd7r3fFHOc4Ip0IaDrzTG7uy8vVRj7vHdLvHBoPl+rAFRr5IYiRWYF6kJSj2EZ/Et+T/PEXxdcfxx5m78oko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647235; c=relaxed/simple;
	bh=xRhfKYfSBOr9Cw5bwytAdhgJ1/25l+YtAwYQKrj4J3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQE7iHeNLeufAw8S2s4sWJZbxs1xeSSoVP4IhZt8U6HeRYKwny5pgk7i/mobm+obIFLmeVODIT+VeVVyLu+VrTDQ2L505kgOzZuHTinJM3bikUzhHXmp15/hMXAiNwtMLxGSfpECFe89UUMFLdLloc6LWnkFw5S7UlKnYUIHf2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T1qCjqNJ; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx43tt7YcUUQGwAck0fyyXzF/+QDdpc3lomRy2C0nU1J5+n790fMOMfmGeuQWqwoPya9SJ9kNajtnvdfVQYQfgeMhSN1zD9OKl8aHv8Wg/M4beiZ/fAy819MzytTzh3cC8JkfrY4suao/Fzoqpys2yZXTqvCZx3Lj3fIxodwoUE4fbrc/yttqe6VXxgr/th+qjLY4qIDONKnX+3v4tA3fy4jamokterpxpZAcWgH5BRldzC9H+CRdEDWH1rws36e+Xo7qCRXpbKTP5TvR63qZ+F/UhtJnGLSbwGut1x6UysXyJ6Y5zHr5MCy5Ch0d+rzbBsmglTr94GVK6qlyKiFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMVVf5dCjxxWleGSdqjaSwFlkonYOF4EUIu3PT6msk8=;
 b=PTxf1RoEXEZ5cHFjDkuM+licYQGfYlg2qorl/Yh50Ad1Z1XHKqF0myWw53AO2a9l+f5fzclZBz7mDUVkax9F/fCw12KSW4+Ytyv/OLNZD5AGOn8wuXxsilLXmmLRB84Ati1n2bkrH5HI5lvVCMdkSXEiL+Mdgb2xDCku3Wl81oFcbT2cGND77gojl7pm/RqIs6NUpwdrSHny2J5m5gehmKZKSuNP8LvWJdenQj5DQ/hxg8vbWlwKKAbaTTVaxE6bPhijHdrS/48qITilqEJWtHYP7ggg1a3ZeLD/gMoBXdLkBTHLPE0rGKfpHwmIbMTKxa/W7oHK9vKitRQeiCCnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMVVf5dCjxxWleGSdqjaSwFlkonYOF4EUIu3PT6msk8=;
 b=T1qCjqNJgjYCQa+rKokI8Y0UseabWzBU8stCH/LZI03P9Wpol6lgHlV9rO00FVI3Lg8b4f60QiAqBI3ZuO66lNXumzqwUM+tRCektOwK1zs3uZbdaMZzW4wvA26X4mN+jbPoDzAw4iSjxSGV06ZqBLMYRrXyCgMXXwmLV+yHYi4H6bjh/S1kF6eQqjpOZ6jNE9g9s+meeVCB2QE0uQMShFfQbEA68xCqv7ynDy68e8li3kzgPi3pCZJsYgLBvibiXUHQMMCSa72kWojkfU3MuIdgASQ+GNrweJFLstHLeMg3WXNgx0xh4QJc/EofUIM9rbl97MN5iCcAYJTNR9iHBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 18:00:07 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 18:00:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: [PATCH phy-next 07/22] net: lan969x: include missing <linux/of.h>
Date: Wed,  4 Mar 2026 19:57:20 +0200
Message-ID: <20260304175735.2660419-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: cab70629-1368-4898-79ef-08de7a17de8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	WssI8lyO79+xx5M+bDA0a9nxj4HMfknlMBw5mridyfr3w8dV7ZlDQ6R+YYYimOhyKZIACJXTSeWhtJjg+Ffh5QrNGw9uBdbGYaH347gc0l7A6uA82GaI2eSw3N8QPLJqO6mpyqV55vEQggkd99LAfL3UjiWX3ZzZTbnPn6QJXmnfYr9j/Q1jjM89DS4S34K8aGdkAEJE333eUecGvupDEdIv6jeaKP9LjK5VLh3J8tnvMRdk6UwPXrRpZVi2xGc5B0MXGeGQkd6kcTl+vFBQ24ipZPhUa6j3MG1dPtjb3xQt5La0GmpDjRY/gsAJ/el640lfzXGTLcGwIYQLshL9NJQEn7XFJNKs1OkQ65PpG38V1K4+auBOF0cYMEbp7YPPcPcjNDZzBFEtC6xE7YudZKJnE2NyFuvsSVWuUw2BTjRzhArAY3maBKVgTjyE9L+xK8qvXCHceh51BkxUIlWm1yeqfgZNBLO1ZJ82utCvqLb9KJsbZFhEZQXFYpYM7dUI7RnsjrEcbour7nX6PnrSW35Z8qqf3rrMxLbhZRpVxe0ZAf7khqHqI1ZYFjGxJz0yK8RacNYQXrjNS/suiNl+YSam+1GeCnfeEyBMC/Zrm+mkMg18kFRnifK39zh4XqKe5TU9DbFY7D6nv8DGLdw/n0FnM8juQjkmzKELFvmxKl5NFrj7S/L66KlVI1eQS6i6w9fouVt9U6iorlKYeTvGXsVJl/19dh4xlrxnQ3+n4ok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TyHy+arygIqYcdFSSNeifFmz40P7z3H8TmkCKVWuHlEgJlFca0H12B/1rYlC?=
 =?us-ascii?Q?mWjrgs09zDZM1isQJVJjGwekP5A7ggaKntUCM7f2XKc/frpdOCRNZhG8c3ol?=
 =?us-ascii?Q?TYAz68wuCCdVAphjudxhxQj2TzwBOkY36wJF0Kk6zRWcsUxCHPahDc9yjQTg?=
 =?us-ascii?Q?2uGzajyIommXfOILYjWN0E0QKRT353nE7iJUGaR0V8DVL2b1ifmdDJtfd1pI?=
 =?us-ascii?Q?wQQWNzcATm8/h4iGAnr/rXV5lEkAodK7FxuD+3B9ZfIRgokZChG/Y9nj3zgW?=
 =?us-ascii?Q?r4zZD7Ft2lxAgN17EMDwhrlFidgtJ9hJn+hU1obAeA2dhFjcpHmjIzQD4RcF?=
 =?us-ascii?Q?g0KqdYEsyktBuwB8cotaMoDsh0z8BidbQ4UuKKf05r1NZpyrx0IAWMTBxAHy?=
 =?us-ascii?Q?vO63g8O6bUtD3FeJQ+iQ9dJcSh7fPgrG+lNjqwfJgt/lhA75xdBDeZCTypal?=
 =?us-ascii?Q?zFZGj3fhSpues0M/cRTcqLkFDADhpQ+XnzVRhajt7l6nNC+Pq+0AP3afqHZQ?=
 =?us-ascii?Q?nOd/rm8ibQqfRTxBJHbio9z5/9asH4GzuFXhmptpTysLzysjFpsr1ghhXHqU?=
 =?us-ascii?Q?xPiy1HHgVxTrXDmHNagjjImo0STXYL4WiQ0Yy2Rdu04zQgmYqx1X28QN+dxD?=
 =?us-ascii?Q?4Qf9djCwyfDVQ8mD6UUy3+tV4fzJvjgFo61vyRLTWDlwAtnCW6d8vB+SOKAT?=
 =?us-ascii?Q?GNCgrwUk/Hd7HfsT8wrt0KLV5NxvpluBooNRMlo8DSGINGvlkt9Cmku9ch/A?=
 =?us-ascii?Q?nlh4uHdcylOW0EL63RMMtrV47outM+RFwURtwclt7Na//8q9VwLBFO3PhCrr?=
 =?us-ascii?Q?U9OYlH2+HMppwP8HTGkzyjbB1SWsFckFjp7c8xc6yySmyV0aEvDIFgHWQAns?=
 =?us-ascii?Q?w0zvCE3czIiPpkt3QrszlELCjihGnk6JV+gr1YY61rnSuXv6CBfESaYeJiDb?=
 =?us-ascii?Q?TiEigfhl43GENpOsBqhIP5oNoQQFTxQQrGL2N8JtgolR0pY6aFNuIkudT/wE?=
 =?us-ascii?Q?TGJFQNKgEwvT6nWxzK4vcIQhNgJeIBKGeyF7CNElaUrZYppKfKGHQIMDF5lp?=
 =?us-ascii?Q?kzw3TN0xNtpTuP/VrOcoZsR0mC2HZE/9nVjoIG6nz4U7beByBh/yCzv+n/y7?=
 =?us-ascii?Q?DVvRLU9UM9k90HxlJMhdTlaGuzilOeZHIBcecPyt/gnX0jlvKNL/c2x1j2h6?=
 =?us-ascii?Q?8ti8jfhV3r0WNWGzE2+Ncc+SCvFfgpMooXgGCqt0mMOgqym90p+yLDDkmnWa?=
 =?us-ascii?Q?E/X302JyB+dkiA1DrmTV/zWWp+pI3lFu9GVw9198E8UTcLahsAxt2ijHamzk?=
 =?us-ascii?Q?92/dgDwuYdwUHQBe7FFzRkkwnMak8zX+bhW9rhunVOyZDhXx0tkjKsRc75WQ?=
 =?us-ascii?Q?IM0t/JBjRmvVAvN82HXsZMEEW5W0TRPuQwUuNBmHxBjgvn9bnKwRQBDhStxU?=
 =?us-ascii?Q?DxsyT66HrSuNWo2kfyyAeUBtnS+bY4zLS94oRExM4VzWGRiUJc/vA99foYaW?=
 =?us-ascii?Q?XxJ07NRjkbh/MXtaR61Lv7K1qfqeBXQFh3yJRBztgV9gESoL8HrdpUBTupRR?=
 =?us-ascii?Q?3EsenMgLFsQPt0YhqQ8AP8DyA6kW1jQAzsHibEMLw1ctgD6Xha0+AhxjNFtl?=
 =?us-ascii?Q?J7Em7jb6S3m9Smoq1BYJVkZ90ilT77h4S+WNzElGg0NTzmH14WYcGm14rd/P?=
 =?us-ascii?Q?9Mj31U9w+IZe43GDZ/CZSLdvmI3elmgyHpjgEh3sylMgFAJ/4mepaNUoTfkE?=
 =?us-ascii?Q?QkpG4B88KmW/aZlb68syCvAQwg0WN9fdgSsdDomfQue3VCliVnM/r9qclli0?=
X-MS-Exchange-AntiSpam-MessageData-1: 3XgO2dtNQEUfoCM+38ul7//tbjyO2OkrrEg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab70629-1368-4898-79ef-08de7a17de8d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:00:07.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faAgVCm/j3mtP3FQRWelTKEbM3ProP8YQQYLz/9Md3Ng4dhoujqtSx7qpRJceooI/CVzn1Qt0A4GB7Qbjd/htA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Rspamd-Queue-Id: 6A117205BB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6896-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email,davemloft.net:email]
X-Rspamd-Action: no action

This file is calling of_property_read_u32() without including the proper
header for it. It is provided by <linux/phy/phy.h>, which wants to get
rid of it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
index 4e422ca50828..249114b40c42 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
  */
 
+#include <linux/of.h>
 #include "lan969x.h"
 
 /* Tx clock selectors */
-- 
2.43.0


