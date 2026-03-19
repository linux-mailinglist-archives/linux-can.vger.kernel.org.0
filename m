Return-Path: <linux-can+bounces-7177-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHXTCQR8vGlnzQIAu9opvQ
	(envelope-from <linux-can+bounces-7177-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:43:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F02D3862
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFD47308C893
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ACA41160C;
	Thu, 19 Mar 2026 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AwhKi6ex"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F840FD86;
	Thu, 19 Mar 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959608; cv=fail; b=KapGXpAZvVSGI27fcQTGLEoY6lJ6SDe0tYAlLdaDyWFgHcHA/5lJRVn91RtUsefo6ILLFhSkKqTRYnW1ADAW0SfCAE1cFzyeTkEfyT3uLqG+4lvYOjWp40jbhr6mctFPd43m7sTx/0eSBeM91qKByCD6DrVdPOTW/VsIYkmoN0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959608; c=relaxed/simple;
	bh=V17FAypacJd8GvSWgJG8ljpWbp49zjCufpfde7d+T8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dENmexygf2Du7YjGATs563gfj62e367G2nlPmD9ajA/fiDpRsGJHaGU/LtcJ29RfGKEeHRPSPPQh+0MryzUqNga4Asu/pv4YzZ2HlyhjXrbTWh51yBRg/sMwePKUT+VZx/UT5j1rrYiU5Q5kBIlEhpw2rLwotXuFOhkVXi3/ZKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AwhKi6ex; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9NGnaXqJlDjy/RgExpg8rj0EE/rG28N96uK0Fb5AlJDuD+8L95bFHtLEEvVUH46r1LuE1T7W9/jE2WcrHkfMbVJyPHL1Xrz5LaD51OtccKBOTs4sSToHLkYfXahH+ImIzWMHNP01uVWkKsN/52jHs9M9P2zFV0DEBlBrwvDnuk4M+pecipGHuRK+ibC/MijumVScPET+KspGR5+n8EQXAK6uFoWK+maPHm+jk/D7LJdRtwJIRfbb2rtduDnPtwAQIdaVWO+MmCfS7U5ovK2jf2ZaJ0kChoVWXUv+eyNgRzPtNqy2818wnn3ltMTkkG9xAbj7Q8YYFt0qIW6i2a0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lLXO85DnJde3dfWH6nGPG6W+cBrygZfZV+X7X382LM=;
 b=xNCgxhzDpFUxKswMg+ZGYmo5FE7vxS9qN4zzTAL+VuWks3CFQqylEC8ojML8u6V65CcbR8lsIqUKmPx12U1xF5HyEwC2Z5YSuvOz/aQTl8rhkulV/OHGtrrIaH6OgeEtWjCf7BL3nJ5NI4nKSIOeBfX0cbCqy1tzC3oYu+UtMTKcNTk/0gwrplY8N2pbGGAgn8OF1NfLdbrMgxD3iZu0Nonsbcp/zWPSK6dPDhXPqNDsKjm/h5MMFfnr+UCOHxShXMYvPVHgvQ4I6hurMi/oF5UNSyYhtiBEA6q7OcZcqYQbJ67qkhcVB3jm6KAvM6r+08UAX4WKI/JCgNF5ay6fXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lLXO85DnJde3dfWH6nGPG6W+cBrygZfZV+X7X382LM=;
 b=AwhKi6exa5sVczsVNQXsuMxBPwG2DVc2m9R39qu8l93XlbIBnyd8other5DECr9PFV97ijGHLWWeRfhG/5Xx0mktsEL5ok2kHawcTriyLOp9pm0to0wSkTyqSH7NrPQvL1n02X3CBZ6a62ZdQImLkOhvE/u8CEKsqYqI/zvrrus2xtFV+9Uc2yol0R/m38dqVCzVAtPDyRW6x4fjcMglxIpnVEsK0JWvekARbgwIFCLoJv61U9/hEP7ozkSaufMcVeWo8uS34bQHRSf9qF9nxXWrOTBJBFOLOAudZIL+IRrc9Gc0FOjJOYyL3egiCQK466P3rUJfIsi/EAzmYXVZ3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:05 +0000
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
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	JC Kuo <jckuo@nvidia.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v5 phy-next 13/27] usb: gadget: tegra-xudc: avoid direct dereference of phy->dev.of_node
Date: Fri, 20 Mar 2026 00:32:27 +0200
Message-ID: <20260319223241.1351137-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0126.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: e83807a7-76b4-495b-589d-08de86077d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HyDlOZ3Z1Sd/4Yad+jTXEEKIRt2LxVS3utQpjTLX0pMma7AiLwhOT4IJpzhnoRidM9T8NoVl3oOM0LIdGV+mcIfXOG1rNJUwIcQzs+WiKcpVzhowqLULhxANotcBBx57rq6ZsvRTRYwJGiN7Fh8cWcqS3LzEqhr280DMAqNnq2VBlEoyeHU2Xof/qKGZVFgmNrtNviAJdfxbApO2ziQE3Bu2ZPAoPoexLUSakzM+dTTTYPaeiHCCAA0Q3Dc0x8ks4SykaQA3nOe+l1fQSgKCqjgYCdclNjbQgSMrcM2076UycgpkNWzVlxqovBHCqtycgsRbbqH9ZEj+KCOmzwpkR4QKRximoca89H2T5MQdu2fW1UuaaQOLc2Ly9fNedZIgxHltmFzc4XSvIq04xikJ1R4rO5NMmauQgMlxJu65hGOQHLdUYzQ+nK3W2+r7RKR+ldxL+awHiLicKgmuY5h/EyxUCIFme1+LbYCQepIp17LpHWQE0407iZ2Hplxf/5u6wB4JBfhxTlYWZEJfDjWFNkQNkWxXePqRE+SkuGGzT7K4ycZJhagxOXLSr0fBTd4StYwIvmJmXnKgBuN/0gSzqbAp29VD7szzSHu7SDyMFnJ+qKInOwcF/RVlUbWQ57ewBMjDw8qjEJ1f0Ss2DC3NP3aowwnPAwj3fLiO2gGQbEDwI2b4LSh61P10xcEpuodMAsuIMT29Hu+StXChiOhVdgLHPHAIrMdV2uz7r2+nDDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X8zAlmMtvpE5MQ7S7nmFF1pGiF+aBrWZklhblklvjDCDZCS4NTglCKpm9cB3?=
 =?us-ascii?Q?keAXqEt6rYoKynOs1+DHUSjOlCxQhdtyvlo1MTKXKS3beUtNSr9lgrj7tjGt?=
 =?us-ascii?Q?VtTgs+hiO6uUs1xKa0BHYc98oipjyEBl4U8PgKZo6kCIZ2NFGA8N+RKcSsJR?=
 =?us-ascii?Q?vFukTvyGaCFDR8G6TBeK/8bTMCE7HJgDZu754/ra+pJ5RlteHcvMf1F8GVSj?=
 =?us-ascii?Q?sdB52YnZGjBqPLWukUL8M9DXm85OhNQDbyygXXX2/YmXDzIit7+7SbdYGOFM?=
 =?us-ascii?Q?iF9fWn4tyYgmEK4OG5/PSkvH1Iw1o61mtzXQCsrJnIjCkaiuECcHpv5nX/1G?=
 =?us-ascii?Q?SRVh4lQPH5W/faUSo7kdglh4hAjCmbYx7K8HIzkHHUkyH0Gd2SpqgdiUSw3k?=
 =?us-ascii?Q?GHXCmC/k5puaeUuV+GIx7ikwi15LUKUWfuAdT155KERsKadwLDMsXoQTgUhV?=
 =?us-ascii?Q?lvuZxkiyPVOodO2wZuHj8AwC5Jd6fpp3FaCravnKSyIT+cSXM2zx0YVAzjrm?=
 =?us-ascii?Q?BBymrmabtRFk6u0R03eJzV2TOXS8r/M28yi2NeRm3GfmNu5PXADfiUP4fG1y?=
 =?us-ascii?Q?3pc61eUyOtjwgOEgNTFPiWcp743XQaSkXIoRzYkCksxSe3BUs+tVhJyo4J7E?=
 =?us-ascii?Q?6yHiILA1Wb2Gcj+mPpWabZ9Q/Wxok6ohQF+moELOjg3YbXLfo6rR6DRGLMJL?=
 =?us-ascii?Q?LAEvC18+20Nu6HTOJA1I3HBMNAScFjIEFMR/HpGV/r9a7jwYA1818mVSoCs0?=
 =?us-ascii?Q?qNRktAPVNTUh5PjEHXx+a1c5X+f4qRzWJeC0tRKe3wPJ+qAJePRKY/q0lkrr?=
 =?us-ascii?Q?8FKQaR9BKrveQLlpc7a4tS41iH5xyl6aqbNhVr/dPWCQXNVqpQ2tBRmlVAZz?=
 =?us-ascii?Q?aMzt//LgmkUnA3MLaBswuL3FlojwKQlAihBJzYUzHkN1aKYb7P8/w5dVlf5z?=
 =?us-ascii?Q?HUGTVn397FsSXQi6Bmv1ft6bWH4ihUens+dbwY1yF4ScQvn3ipZga1QiwMd+?=
 =?us-ascii?Q?8FLV6JVNKFugtv9hFlR+/ekEcfzxSvsX3N6rguUmjhnxsd78fz9El0iGvQz+?=
 =?us-ascii?Q?Zep7+EK1EOBc5/+LA8tjArSEPKqJ/pTc5e7T6EtGl1rXtRQA0fnRNR+Pm4S/?=
 =?us-ascii?Q?9hpBCcLrAjxkXBjs9WpqCIbELztmVMEmVcBkOvTutj7893+uSnTRf2xE1rW8?=
 =?us-ascii?Q?sWpqLJ7eoEij7DxQFjY6+sjpIJs74/VuvYipRsU5SMdMMb6ThwjEyhAAodVP?=
 =?us-ascii?Q?N9ICaC6/QhQq5TXle/PjiaJtbvGwq/9ZtWKuIPhkUWizg9vyfTrH1ZEKXHaz?=
 =?us-ascii?Q?ja79UJQ5WFO6A407XN9xfY2ZVEQ5J/QWiAkA29c+UFejj0W2Se/HvAku0R8H?=
 =?us-ascii?Q?WL5OPPEFkUfUJKc/4eyM1aSDW2lQlqx8ZoTOhgZjHdHtaPDwmqU4npwVKC4U?=
 =?us-ascii?Q?1MdJdZWFw8N0voYIrBB+QZnOSbZWpJ6Fn04ymie5iX/yczA8hPUl4vYitxWA?=
 =?us-ascii?Q?t4MBvVo/UQWWrteMw6r7mgrOt6XXusAhkWey50rLrSvSLzhgNJUMzy4dTHgR?=
 =?us-ascii?Q?sQA4JKZChHrc8g1LvKdOZvLpTZE7SVoPrh+F2JNlEz1kzsd1m/JTmCbYkvt/?=
 =?us-ascii?Q?P/iCY2I/0ubzEK3iKsjo9wzELzA7HtRZeXrS95hzhCo4dOlun5LQ/fn5ably?=
 =?us-ascii?Q?5rJSGb82fSffpCrGUV5HWGn4UaKu9jj1Jt1hc68gaUMmeiuDCI1PqKqRbqT/?=
 =?us-ascii?Q?E33dr4CYjVbB+x0lgVK3luKcFE9CfQirT+BGlD942xJRRNQKEuIcO4G2sx6h?=
X-MS-Exchange-AntiSpam-MessageData-1: wLrNvYVNzY8wwMvHQsib3F6D9BLs9XH2GuE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83807a7-76b4-495b-589d-08de86077d51
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:05.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XgDEaZmg6ktpbLpqxc3CBM9jzjybtrKQrE2sq7Uf7hal9CQmZ1AtW/jSQWw8fdr8mOmQbdOzvKKDaA0eeYLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linuxfoundation.org,nvidia.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7177-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,linaro];
	NEURAL_HAM(-0.00)[-0.910];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,intel.com:email,args.np:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 486F02D3862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In a somewhat similar situation as the Tegra USB host controller driver,
the Tegra XUDC driver for USB gadget mode needs to get to a struct
usb_phy that sits behind the same OF node as the Generic PHY. It does
that directly, which will no longer be possible. The PHY provider is
also the xusb padctl driver.

The rework here is also to implement a parallel OF node lookup path
based on the "phys" phandle and the #phy-cells of the padctl provider.

Some further notes:
- create a local "usbphy" variable to hold the devm_usb_get_phy_by_node()
  output. This makes the error checks more obvious (avoids keeping an
  error-encoded pointer in xudc->usbphy[i] even temporarily).
- the "if (IS_ERR(utmi_phy)) .. else if (utmi_phy) .. else if (!utmi_phy)"
  pattern can be simplified, considering that neither the IS_ERR() nor
  the NULL case continue execution in the current block. Therefore, we
  can move the case where the "utmi_phy" is a valid pointer outside the
  "if" checks, and this reduces the code indentation level.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: JC Kuo <jckuo@nvidia.com>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>

v4->v5: patch is new
---
 drivers/usb/gadget/udc/tegra-xudc.c | 35 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index e9d33be02866..cf4e6c87e44d 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3494,6 +3494,7 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 
 static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 {
+	struct device_node *np = dev_of_node(xudc->dev);
 	int err = 0, usb3_companion_port;
 	unsigned int i, j;
 
@@ -3515,7 +3516,10 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 	xudc->vbus_nb.notifier_call = tegra_xudc_vbus_notify;
 
 	for (i = 0; i < xudc->soc->num_phys; i++) {
+		struct of_phandle_args args;
 		char phy_name[] = "usb.-.";
+		struct usb_phy *usbphy;
+		int index, err;
 
 		/* Get USB2 phy */
 		snprintf(phy_name, sizeof(phy_name), "usb2-%d", i);
@@ -3525,22 +3529,31 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 			dev_err_probe(xudc->dev, err,
 				"failed to get PHY for phy-name usb2-%d\n", i);
 			goto clean_up;
-		} else if (xudc->utmi_phy[i]) {
-			/* Get usb-phy, if utmi phy is available */
-			xudc->usbphy[i] = devm_usb_get_phy_by_node(xudc->dev,
-						xudc->utmi_phy[i]->dev.of_node,
-						NULL);
-			if (IS_ERR(xudc->usbphy[i])) {
-				err = PTR_ERR(xudc->usbphy[i]);
-				dev_err_probe(xudc->dev, err,
-					      "failed to get usbphy-%d\n", i);
-				goto clean_up;
-			}
 		} else if (!xudc->utmi_phy[i]) {
 			/* if utmi phy is not available, ignore USB3 phy get */
 			continue;
 		}
 
+		index = of_property_match_string(np, "phy-names", phy_name);
+		if (index < 0)
+			continue;
+
+		err = of_parse_phandle_with_args(np, "phys", "#phy-cells",
+						 index, &args);
+		if (err)
+			continue;
+
+		/* Get usb-phy, if utmi phy is available */
+		usbphy = devm_usb_get_phy_by_node(xudc->dev, args.np, NULL);
+		of_node_put(args.np);
+		if (IS_ERR(usbphy)) {
+			err = PTR_ERR(usbphy);
+			dev_err_probe(xudc->dev, err,
+				      "failed to get usbphy-%d\n", i);
+			goto clean_up;
+		}
+		xudc->usbphy[i] = usbphy;
+
 		/* Get USB3 phy */
 		usb3_companion_port = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
 		if (usb3_companion_port < 0)
-- 
2.43.0


