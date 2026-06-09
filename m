Return-Path: <linux-can+bounces-7785-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CapDGtQyKGrc/wIAu9opvQ
	(envelope-from <linux-can+bounces-7785-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 17:35:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DE661CED
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 17:35:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="B/wnVtjq";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7785-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7785-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29B1315CC08
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A43914E4;
	Tue,  9 Jun 2026 15:26:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6242D060B;
	Tue,  9 Jun 2026 15:26:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018786; cv=fail; b=mGJeriAIBRQO8eJgMWYbiaQ2KYSwGeNTYt35lIl8eZDySUZGwiTBF9nlApYcF9jh1q17DuhAwFNvOAPZ86tNj5v80NAyzE5XPN0KjDtRANh1aT78FtyNAXU+3go7TDZEaRlauHg9x0O2ri/sruiX1cu4ayvqMzWZgcBfKdJybQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018786; c=relaxed/simple;
	bh=S2EPicOSkIRjXCy0jEHq2RAVLKT6QifsdBpTlI24UQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XBeZm6qtvj5t8dVXbZPtO5HNhbcfz0kfF9ELdTPjYJlY5iPsV/RUyTM7hw+L2YATLqlG580CQYbuJuXzs8Z7+3o5bKjx+39YcqKqO09Sp5VRSKMimf3oXf+5peTgYFXA7900uwD4X2mxGyMZ+9fxZZLhlstmrACrXojPpd0Fz3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B/wnVtjq; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSd/DfcTshDS3KUYn/wl/yso2pbH8xf3/wKf1Mmx5EkdhTX0IpABR7y+sp5dwULZUasilo/ZYE67e3hwJFyTDK09SNrrxKIHgq5SKhc481/nDyACB32Q2w+qyRc1V8ApTN0zXxAWRWRQu/rLY+ZIQ+WzRha8EizCeMK5xyQOH4rZ76cZwbhllsibH1ATNC58XSI7kAviBJy2ZwfgMqyVLjgIrrmQysEW7en/r65Tn9+bGYd3Aj1oN4jTql/Kp83xi0XILXLXGKoYdq0Vwc3h7Kcom+dDm4GtoOWo8bzOwocr8ZAMm3rmWDLv34lQ6WTb4Nh+uKvidfYNjqqZCldXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjdIrXBF8zvOts5cbhC9XD6ToHdg+8F9jFq6HE+dMVI=;
 b=KL+h6KOBv2CtXeow0XXDenB/dq2tY1Q2m3QDwsouH8ZF75O6ooRPZ4FQum7odLfr6EcfEOFpddPPcaKP32FRPxDMuwU/URom5OGucdXlfPWJGfuPxPZD1B1iH8i6Z1U+IUnZUQRKHrgH41zMDPOCiqGpO7fTPqEYlSsHXxZXFbb+eWfACauASvo6mssJERTqjU8KoxHE7+mqteYajbEULLhywY+7oNqgqfLfkdqov2yqcpkb2g/PqbqIj2S8J6Pd5KbyvK9kF1RkJ4tR19OChsYKyPs9LRy7bp46/r+trhu+Ytauh0Pgk47nczj9lLjaOyRVNNTkcy0CYWwQrWCTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjdIrXBF8zvOts5cbhC9XD6ToHdg+8F9jFq6HE+dMVI=;
 b=B/wnVtjqY5XU1+n6Wzd/8daTpAXhfLL92qeDyYDUyjZjQ8hfiC0kGrzKqh/Z5ZjTS7Lz+giqaulslgT6ZW+rjfF5nS0Z8bxflntjz3pWc1Shl1RQ3ThBnngqTYUB20j348a4rv9IkAsqsItzItiFFVD7JYjGAVILMJNH5uNNomdLN1ePcQiGaEuN4ai9850p3n/Wkv2KGhFDmRK6dSTz08u887ZSybyvBgyIcvlN1EDz0X6DuR9kpjkKORvEA0uLpuIHMluMPottzctbBy0BIHnVI/twXTTHOCdoklUcJUvvv5WXXA5lbd6m8y0/Of+Hro5SPjz9k5EjAZhuwo2n2A==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 15:26:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:26:18 +0000
Date: Tue, 9 Jun 2026 10:26:07 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com,
	shenwei.wang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	nico@fluxnic.net, adureghello@baylibre.com, ulfh@kernel.org,
	linux-mmc@vger.kernel.org, linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org, olteanv@gmail.com,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCHv2 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
Message-ID: <aigwj8tXnEKjWkgU@SMW015318>
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
 <20260609142139.1563360-6-gerg@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609142139.1563360-6-gerg@linux-m68k.org>
X-ClientProxiedBy: PH0PR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:510:4::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b657bf-c6d0-4c4c-ae3a-08dec63b73a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yPKoYWtQ4ycKbRTkCwd/SFz7LwjynupC7+cn0nBo41HXTGiGk1/Vk8zvDUd6c4GSuT1jvrlexyuDtrtsNR/bcvIB//iNXE8LZMFqtj0IcR73RuAkgQyRivF723XwapVskCCWmV3cayGrC8Vl/I6JiQqAZCI1493oLZ9PWanllP58s68n9ylEtbuJxMfWTtp1p22qYU0oK4ajeNIqdU2hOxdKjRSC2kV41DgtzahSdXQKEpPoWuyUhFnu1klGqNZi6iLY28cDTwvcMf/0OdIh2j1TNdzrAUS2uOKfILuEmKilSdJuqzDkbMoC+DY/T1nrjQu7nAYr4DUlokZycfRoGILzvNQFcA8iYe2BvCGbJ14mpGlGPmxjIRfSk3Wcu/w5fDsbmsMfEBGYvVBDJqCGbFAVGIsmz0mUPpm3rZCcznRfxX17gxcnZg5zR/+2uGoQKWXosWEMJ8vgsnY2C2MEzUhdkcV9FCcnAFXPDict/1pIIB/2qTbD7jbm+CR/8byHfOqo75SJYB5R8ZW9mSQ1V3KwFnsRZc548IxbFBL4PdGqDQchhZNN2ufu149ehPOmBClx6536TcI2xrV9bzB3Qs5l0I3oLRTeA34wh9yiynglm1Ep1pAbGMiQL8uxHzJIlvdN5jf8wGYllWHznoXe0F6qOHe4KgCmPnij0vDg3AV0KgDNYcZ4IbY7Y/ksOIuZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZ0OvQnFpzFu1oPXNUJ14NXCqYOsvgtBZeQ6hdpwFcf2hTdjKU8w+nWSzKyN?=
 =?us-ascii?Q?SSO5xKIpv4AAgSYpmVzL1vCW+AxwHQ0hahuh5JSLZyFB8iM+aek4AJfXLdIL?=
 =?us-ascii?Q?QjzQ3eUeUl8VWvgfsQp9aDeh0jIT04ggPVEBV5bccBQtBpU7/lu4GJ82WpMX?=
 =?us-ascii?Q?nqDvPyriX+O4PwKKxMGLeajhOo/fX46Cv7UulAdvrmIz+YkkEb8N4Hce/a76?=
 =?us-ascii?Q?pnrqgMHxwnJQvnJ1EW+q/UNn+w684kt2rfC7lkn7JrvizW7PwrMgNZoY7IIr?=
 =?us-ascii?Q?N7WOcAZOeHdKUlkpKfBJ7rWNkyOzmxB6WpVR5P7fZmioeUahizTQMdvDKGqN?=
 =?us-ascii?Q?OPNJyJkhY1q3mKQY9ldhitvX3XpC+DwU1bVn0hN+/CIM+mbi7wU5qe4mJFRv?=
 =?us-ascii?Q?1rGqQJxOkowX5M7SPzIygtNwAkVHNsdGa2slB1A3YFP8aEwRnt5MRVRzHgz4?=
 =?us-ascii?Q?Vo6dOw6v3UYcFvTE8q8hpzW0HWq+g6tmLFwk8sI2FSsNlRKTav/ppJEumGtO?=
 =?us-ascii?Q?HeXOQ6R1H5kxNqdn0loSXq6RZnGMkF4zBzDS1unGBTvCVsJHGyFI3+ggsOBg?=
 =?us-ascii?Q?f7BqUCVIrH3bii+TYWLI8wVkYbOxaipk9cHcVUwW0UOFl58mPXqz+U0pKigP?=
 =?us-ascii?Q?nMP4Y0oCg8bsypsFHb9AklRkCzgZcZOk2OkGunkipjx5pj03XXg40OfnYD43?=
 =?us-ascii?Q?sReVhnGzWWbcdgFDlXeXtqCQTMxFoNZdKBZCI+F/zHCFWRM6ZAmNDN/IP1Ia?=
 =?us-ascii?Q?APRq9HxZVtoA9TvopXdAh21CwXZrBERZHyxKPv6KSkdCCopeNeqHZHBfSmB5?=
 =?us-ascii?Q?25xsfxiiKMH3rSHrx0DlWKwBi6W9S0ia3DlQ0OPQLQ0Ihihb1qbM/rE4Y34K?=
 =?us-ascii?Q?ew1fLV2SW0/5KYIaCBDDw6UkjO8m4hJmzs4zik2SobLwdl5KfT83BFxGgWgw?=
 =?us-ascii?Q?NerpsJgz7nSNx0x8doPbi2CBRhPRUwsPpOv4TrIdMTQgl6qG0ai4ILAPVtma?=
 =?us-ascii?Q?Z7PjVhRAe3aHIJQeNR3WBYtOuYihAQvgGA83LnyGFxbZLljeDExt5Gdg0GLY?=
 =?us-ascii?Q?VuhSVY2s4VRP0wBZx4UmLrj+/tP1FPMWNl0N+J0U2Br6GdJmujTynaSin0Re?=
 =?us-ascii?Q?r1B2SU42GpuBTd4vhlZwv2eHUw8oAo2OUye0P161p2kuVXHNpOzkUZhlvJFJ?=
 =?us-ascii?Q?jal59Zq05bCdBdl01KKXj51AoBMWdRNiL0oCTVqtBVWVMuBPB6qK9ovK3C5g?=
 =?us-ascii?Q?oTmZpVqUPDsnyrzR/kjS8dNOkuPQkXsHbozIIfH9m1jTWzn1GsJI2GbDl8uo?=
 =?us-ascii?Q?3YN26rF9GHY1Y1qOA43kSNFXudNIIxj9/hi4b8QWbmtaYcZyLGUFlewCX476?=
 =?us-ascii?Q?s7evX9UGD6Vk8dQhCKKzxJLO/3bdQlt9UJKudj+BVdYUc2UO+UW3+gncxfks?=
 =?us-ascii?Q?nTBRDd4B3fbjvHdStcNAUZXufVWGsMpUcc97ezfqvEXcEnN8nzaCl+5GjiOe?=
 =?us-ascii?Q?Dmznedds6SIucilaSpDabv0Ryg5dSYx78RwdTHuAZt5Mz5Ho0t9F+u+A0n5n?=
 =?us-ascii?Q?aAKERTVj0WBHjbf+tu+X7fumEQQwFWWBkSqEaBj4PUbl1UFm/+RQRvIOqnmB?=
 =?us-ascii?Q?fgIuzFku/Yl+YXGqi1zYDVVhwJFCKz26EjURWX1YJghuwn4AA9/AKn3V2XeT?=
 =?us-ascii?Q?D7GfSbXpTWvi6sJaK7BXQnHkfIqxTyyDV34Q33A0/+bA91ACbZYt2GJo3ULs?=
 =?us-ascii?Q?7k2wmqtFHMR2+hRnOkxdLG9oU89XpG1XgudYbWgVbtpnY/vbwwMM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b657bf-c6d0-4c4c-ae3a-08dec63b73a9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:26:18.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZaQL8w3tw9XvCYpzDO/SPoavJ4qY2vd+OYDj8ZNgNYRAfUD9nbP+6wktfcQ2Y9hHgOv9LnOnNSSgMDmIFF25o0ZqyNcGGj2juZo8YlYvK3StRcrd4x0yDdWzn6AeOjM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7785-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gerg@linux-m68k.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,m:mkl@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux-m68k.org,vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com,pengutronix.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,SMW015318:mid,oss.nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,linux-m68k.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A22DE661CED

On Wed, Jun 10, 2026 at 12:13:01AM +1000, Greg Ungerer wrote:
>
> Remove the local ColdFire definitions of readb()/readw()/readl() and
> writeb()/writew()/writel() and use the asm-generic versions of them.
>
> The implementation of the readX()/writeX() family of IO access functions
> is non-standard on ColdFire platforms. They either return big-endian (that
> is native endian) data, or on platforms with PCI bus support check the
> supplied address and return either big or little endian data based on that
> check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are currently broken because they are implemented
> using the readX()/writeX() functions.
>
> The change to use the asm-generic versions of readX()/writeX() itself is
> quite strait forward, just remove the ColdFire local versions of them.  But

typo  strait?

> this of course has implications for any remaining drivers that use any of
> these IO access functions. A number of drivers can be independently fixed,
> before this final fix to readX()/writeX() for ColdFire. A small number of
> drivers cannot easily be independently fixed and remain in a working
> state. Those drivers are fixed here as well:
>
> drivers/dma/mcf-edma-main.c
>   Supports big-endian access by setting the big-endian flag of
>   the drivers struct fsl_edma_engine. But locally should be using
>   ioread32be() and iowrite32be() instead of ioread32() and iowrite32().
>
> drivers/net/can/flexcan/flexcan-core.c
>   Setting the driver quirks flag for big-endian access will force
>   driver to use correct access functions.
>
> drivers/spi/spi-fsl-dspi.c
>   Setting the regmap format_endian flags to use native endian will
>   force driver to use appropriate big or little endian access on
>   whatever platform it is built for.
>
> These drivers have only been compile tested.
>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for drivers/net/can/flexcan
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---

Looks goods, but no hardware to test it.

Reviewed-by: Frank Li <Frank.Li@nxp.com>


> v2: changed from RFC to PATCH
>     use separate regmap config for mcf5441x (spi-fsl-dspi.c)
>     reorder quirks for mcf5441x (flexcan-core.c)
>
>  arch/m68k/include/asm/io_no.h          | 68 +++-----------------------
>  drivers/dma/mcf-edma-main.c            | 14 +++---
>  drivers/net/can/flexcan/flexcan-core.c |  1 +
>  drivers/spi/spi-fsl-dspi.c             | 14 +++++-
>  4 files changed, 27 insertions(+), 70 deletions(-)
>
> diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
> index 4f0f34b06e37..2f12f4ed0da5 100644
> --- a/arch/m68k/include/asm/io_no.h
> +++ b/arch/m68k/include/asm/io_no.h
> @@ -3,15 +3,10 @@
>  #define _M68KNOMMU_IO_H
>
>  /*
> - * Convert a physical memory address into a IO memory address.
> - * For us this is trivially a type cast.
> - */
> -#define iomem(a)       ((void __iomem *) (a))
> -
> -/*
> - * The non-MMU m68k and ColdFire IO and memory mapped hardware access
> - * functions have always worked in CPU native endian. We need to define
> - * that behavior here first before we include asm-generic/io.h.
> + * Historically the raw native endian IO access macros for non-MMU m68k and
> + * ColdFire have accepted any integral value as the address argument.
> + * The asm-generic versions of these expect "void __iomem *" for the address,
> + * so define local permissive versions here.
>   */
>  #define __raw_readb(addr) \
>      ({ u8 __v = (*(__force volatile u8 *) (addr)); __v; })
> @@ -45,66 +40,15 @@
>   * applies just the same of there is no MMU but something like a PCI bus
>   * is present.
>   */
> -static int __cf_internalio(unsigned long addr)
> +static inline int __cf_internalio(unsigned long addr)
>  {
>         return (addr >= IOMEMBASE) && (addr <= IOMEMBASE + IOMEMSIZE - 1);
>  }
>
> -static int cf_internalio(const volatile void __iomem *addr)
> +static inline int cf_internalio(const volatile void __iomem *addr)
>  {
>         return __cf_internalio((unsigned long) addr);
>  }
> -
> -/*
> - * We need to treat built-in peripherals and bus based address ranges
> - * differently. Local built-in peripherals (and the ColdFire SoC parts
> - * have quite a lot of them) are always native endian - which is big
> - * endian on m68k/ColdFire. Bus based address ranges, like the PCI bus,
> - * are accessed little endian - so we need to byte swap those.
> - */
> -#define readw readw
> -static inline u16 readw(const volatile void __iomem *addr)
> -{
> -       if (cf_internalio(addr))
> -               return __raw_readw(addr);
> -       return swab16(__raw_readw(addr));
> -}
> -
> -#define readl readl
> -static inline u32 readl(const volatile void __iomem *addr)
> -{
> -       if (cf_internalio(addr))
> -               return __raw_readl(addr);
> -       return swab32(__raw_readl(addr));
> -}
> -
> -#define writew writew
> -static inline void writew(u16 value, volatile void __iomem *addr)
> -{
> -       if (cf_internalio(addr))
> -               __raw_writew(value, addr);
> -       else
> -               __raw_writew(swab16(value), addr);
> -}
> -
> -#define writel writel
> -static inline void writel(u32 value, volatile void __iomem *addr)
> -{
> -       if (cf_internalio(addr))
> -               __raw_writel(value, addr);
> -       else
> -               __raw_writel(swab32(value), addr);
> -}
> -
> -#else
> -
> -#define readb __raw_readb
> -#define readw __raw_readw
> -#define readl __raw_readl
> -#define writeb __raw_writeb
> -#define writew __raw_writew
> -#define writel __raw_writel
> -
>  #endif /* IOMEMBASE */
>
>  #if defined(CONFIG_COLDFIRE)
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 9e1c6400c77b..4ed0ce644e37 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -21,9 +21,9 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
>         unsigned int ch;
>         u64 intmap;
>
> -       intmap = ioread32(regs->inth);
> +       intmap = ioread32be(regs->inth);
>         intmap <<= 32;
> -       intmap |= ioread32(regs->intl);
> +       intmap |= ioread32be(regs->intl);
>         if (!intmap)
>                 return IRQ_NONE;
>
> @@ -43,7 +43,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
>         struct edma_regs *regs = &mcf_edma->regs;
>         unsigned int err, ch;
>
> -       err = ioread32(regs->errl);
> +       err = ioread32be(regs->errl);
>         if (!err)
>                 return IRQ_NONE;
>
> @@ -55,7 +55,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
>                 }
>         }
>
> -       err = ioread32(regs->errh);
> +       err = ioread32be(regs->errh);
>         if (!err)
>                 return IRQ_NONE;
>
> @@ -203,8 +203,8 @@ static int mcf_edma_probe(struct platform_device *pdev)
>                 edma_write_tcdreg(mcf_chan, cpu_to_le32(0), csr);
>         }
>
> -       iowrite32(~0, regs->inth);
> -       iowrite32(~0, regs->intl);
> +       iowrite32be(~0, regs->inth);
> +       iowrite32be(~0, regs->intl);
>
>         ret = mcf_edma->drvdata->setup_irq(pdev, mcf_edma);
>         if (ret)
> @@ -248,7 +248,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
>         }
>
>         /* Enable round robin arbitration */
> -       iowrite32(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
> +       iowrite32be(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
>
>         return 0;
>  }
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index f5d22c61503f..f0571b97817b 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -295,6 +295,7 @@ static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
>
>  static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
>         .quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> +               FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |
>                 FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
>                 FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
>                 FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 9f2a7b8163b1..abd3b20c2f17 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -192,6 +192,7 @@ enum {
>         DSPI_XSPI_REGMAP,
>         S32G_DSPI_XSPI_REGMAP,
>         DSPI_PUSHR,
> +       MCF5441X_DSPI_REGMAP,
>  };
>
>  static const struct regmap_config dspi_regmap_config[] = {
> @@ -238,6 +239,17 @@ static const struct regmap_config dspi_regmap_config[] = {
>                 .reg_stride     = 2,
>                 .max_register   = 0x2,
>         },
> +       [MCF5441X_DSPI_REGMAP] = {
> +               .reg_bits       = 32,
> +               .val_bits       = 32,
> +               .reg_stride     = 4,
> +               .max_register   = SPI_RXFR3,
> +               .volatile_table = &dspi_volatile_table,
> +               .rd_table       = &dspi_access_table,
> +               .wr_table       = &dspi_access_table,
> +               .reg_format_endian = REGMAP_ENDIAN_BIG,
> +               .val_format_endian = REGMAP_ENDIAN_BIG,
> +       },
>  };
>
>  static const struct fsl_dspi_devtype_data devtype_data[] = {
> @@ -303,7 +315,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
>                 .trans_mode             = DSPI_DMA_MODE,
>                 .max_clock_factor       = 8,
>                 .fifo_size              = 16,
> -               .regmap                 = &dspi_regmap_config[DSPI_REGMAP],
> +               .regmap                 = &dspi_regmap_config[MCF5441X_DSPI_REGMAP],
>         },
>         [S32G] = {
>                 .trans_mode       = DSPI_XSPI_MODE,
> --
> 2.54.0
>
>

