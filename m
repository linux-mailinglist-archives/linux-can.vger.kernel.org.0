Return-Path: <linux-can+bounces-7487-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC1FOdu5+WlICwMAu9opvQ
	(envelope-from <linux-can+bounces-7487-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:35:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8826D4C9D73
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDD5F300D743
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364A32D45B;
	Tue,  5 May 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cr4UYMq7"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE23242A9;
	Tue,  5 May 2026 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973702; cv=fail; b=nXT5UMBxQ2RNeGzOg2NbNJvPDV1/7mzNJzFz70AWU16CeIFwUr9EQuKq51p3xhNpI9jYmMCoQ3+mAuFYU53saUmUXZmfdS0vytP1BtlQnCrauVM8nTHtUmHXUsWLKJTWC+025wvSAxpkcVdFYIwkrAVMAtpCRSHh9xBqMw7BvUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973702; c=relaxed/simple;
	bh=SgTScyAujxw5hlQDlhShWym668ReAXj3m/ns+SwRWy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpI6dGcxLe+KreMzakO6nJk6ZfUpG6bcy8tLkjd2QAQrrDnq+A+1oiNTpt5NNWQgyhVFtLUYN6eYAW/VJ9ri7FiPZoUjjKGk3i+WZ42h53NK2bb3+qArNGQHJRcxUs85WvWeSLBl/3nQkF94ghwjCgLaoU/R1hZGryNHKRayZjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cr4UYMq7; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA4juv1n1gxn1dRZINBnO7Xac5QaYNUYc/0jgXEB6FuAqamUWhIE6Hl7FgQh1TimKaGjgc4q5i6WriTVs+hHWkTlUwL4AYIxQFjaqVCAdrrYBkLqZ/HqQWmn4piwyHQWhxzz2bNN/rVvMIBBpgMxooVmap8zb/+SJvvahqLVapn6wBfg9WYxuVfh8YA2RohMz7x84Gs34L41vTFbJ5uuj2D4N7Sbqovl3jQVyNOzPCdU/DM+mNA5bCJ8QAI6hIL77WconcPbZBKHxRJ4g6u0B6UHhXHUoJ4UtNPRJjsz5IixLlTCyY1HDE7S20rVBTakcsQ0VL0ZvvtYqGg+48bHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrfXFBxaTkwG3F4vpSrKWyGG9VEG+HyW79q9UI3kISw=;
 b=U6RIbFSnJxuWPuUovcYTLmW9p97pRhptND7VyGz8206m6r+9+pVxxp7+xOJVJjy61f3wvsnPXSldvLCR4olNkuILQKxY9Oea4Vz5DJfZ+7py7arM9n+q7M1r4xBfAyl8Z/ESLLzy0r/1dtfUWnlFEj2UNhHD+YJL55AmPLzyVzEsEWfqcaS8JbRNfWJYiM2afdPgkH+9u9sN0uqdnANp8I/uNpAzuYah75WkDVHlQH/KHY55SCmgTzGoutv6WvjSR663oAPGs4O+WZ80a++LEoOiEcNs8TPNmPXCgHY3/IVevzA1pb7TRylPvVb+n3alI/5qieY5tALoaWxamJirAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrfXFBxaTkwG3F4vpSrKWyGG9VEG+HyW79q9UI3kISw=;
 b=Cr4UYMq7ZvK7rSYJuM9IO9Fg+J/T8+liiLNCx/xQDNHSIeVXOiBF8C3d/n1pkXNz3JUPvJozrrrFWNJXhm4qXvkvFMWv/cv0d4/uR5Z8eES9T4KZBch/+TcpTpT3mv83h9/+2E0A676QcT261ZeBo6bDNJELu0k1LVF2kGWD3O7EWVgIN1XmJ4VK35mgUelqZtsoO71LtpXN0VZlgnPQXUAEGfIOyyuiFe245KUjeHrdnuoZ+7CJT/gaQXUgXOhinUsBZiYrKeHPw9+qchjE/EPCm/vLzmZ+AOhDYR6y6yhQR7/hwv1cj03tcyc6CesTP9IS+9NBmYhCZjXE+XUg/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 09:34:56 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:34:56 +0000
Date: Tue, 5 May 2026 12:34:51 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	JC Kuo <jckuo@nvidia.com>, Johan Hovold <johan+linaro@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 phy-next 14/27] usb: gadget: tegra-xudc: avoid direct
 dereference of phy->dev.of_node
Message-ID: <20260505093451.ll4agt6lmlixsz5g@skbuf>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-15-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430110652.558622-15-vladimir.oltean@nxp.com>
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM7PR04MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 299da94d-f720-4412-f8dc-08deaa8991a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2MGr/f+sIHDM+kMB9zfAPP/V2MGkg2njpS99D01eJkXeaHJlx+CUOGE13d8u3izBrYxnthzewExWM8LnJZZWvEsBh9fbKmSBlvTSxH25jIJbnkpDKby0dV+heLxkcWHTyp4LGLszjDm2DDGNpxBVOQ9+3cKwqJfOvVB2FNWpI2REdr6lFM3U8k8J2px4O0hYr6bdDU+32I6L7+py03IXd/rtFm9CgAJdxS9sUbjEaaZwfPyNxwz+yUUW1DOVwYzMJEOu6Q2sDnucMKeBJxvncXwCKfzHUtu6w/nEYKu/oA/IYLem4m+JnnLSKaFzJZV3Fg871RmkvD1ensZHxp9b5d9ereE6wTamVVMxdgoe9X5kxD/MSVxxEgd8E/oiW2R3OcQ6VEmrQbXYaB/4f9qJ+kILOb6DLZSFMrRBnhyOk6zi+wnZ3HTYkJN5PnKK54GnZ9eFM0kQGRuTswnWT/7YmNNBkVVdmn42W2YM9gaF4k3vR/aVT5oYHSs88IeAbbEGVdqsXOvQNjVtZ8IbMicXx0e2K/WInPv0koNuQlyvTQe2Q8KdWcoJCVvO8/No1RXWYYL3HlP3iVk/kbdtAEq+An2LT5qTTlP1r9NCzRLptkUpxlR4MyrYXAv+ziPqcTXHysL78NRHSMmgrpoXUdRDJbTK9LOGzgSbJjZ05fMaGtEp6rtRRo2vdhKosD2c5H6P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uxuLjGGxM4YZsM1a0pkwE7ym66Ne8cfhuNj1ewmXJvz+Idpv1QylbY4nas+?=
 =?us-ascii?Q?LLoj23JRcxSba3JOev93pD3OiuZrLNcd5gJ3TaouSgFFeF1LFqSleZCNJ6Xd?=
 =?us-ascii?Q?f/7ipfmgtZ2a+umokjw8lg3NmtqyRUkxBdndnsiRbf1VjTGv90B2kg1Ft64O?=
 =?us-ascii?Q?s+iuxwIcBhGFsmnn9CcCYK1/FmIOBrsR9oi2EOHZE2/621BkE3k9jDkwavxe?=
 =?us-ascii?Q?c3QtgsG5ujYbB8RJueuUK4E2wsV1Qm8M2IfLVNI0C3PqeiT0VW5mJaq7Hz6U?=
 =?us-ascii?Q?9vGvclv4pj91gZXIOHG/cL9evTNU/W1+nK/LXDEIg/N0qNp/h803d9rJJwue?=
 =?us-ascii?Q?NFM4LqlXfCshWxbuueCKW8ZPd04F4aw+x1nndd2O55RfPixBTuP+3lO0UHhE?=
 =?us-ascii?Q?b1gd39562KyPOsHRnEanZJvbMinz2z7dwfr1XC58rJRp/w5bO/uvtUseeRQw?=
 =?us-ascii?Q?l6CeUWkUF5I9N+WhiED01/S05sQrwnl0WidKfz6CnRqb4eYAOnx2OJIeEHnU?=
 =?us-ascii?Q?8n9ach8lLQJWy59qU0M8mPypwNhS97ENiSWWjfJDOREKSkVpuUKKOy5GP597?=
 =?us-ascii?Q?3vF5DjMZs1u1yc0wEKJbf2N9Jb6NFnjlkB2H02AIwCLGwK9T8unOv+gf5puH?=
 =?us-ascii?Q?LzGl/hzk5DV5sTR+SkfGqRrAcoAO6IxwmzIvr+Y5s66VuVIN/uItZl+SEXcj?=
 =?us-ascii?Q?7hSifevmybPLq2iq3HKu2DYpdrrnbuTb+vYcwx1c0sqTiVUmwihRErPuIGsO?=
 =?us-ascii?Q?+olT3dQqSViTu2wSLPydrrLU1LSS6MY2jiBv2aMHcJegXe2gm4FPwQcrLl0g?=
 =?us-ascii?Q?VvSQTjc0fb6Zib+sXPdYPnhUzgPzpGu7zG2bX/XtyZWuvGfYCs99hKjNzbE7?=
 =?us-ascii?Q?RyC7Vh2/DlAWCZdcI50D1xxRegmgZ9fOOIqzRHBXW45TI5hqrlhGRgwnx77R?=
 =?us-ascii?Q?VAv7aGnE6k8hfGsaHvFpjT2Ns5/CFRaEkspS/G+rCnrKQ84FfWHiIHpI6jt2?=
 =?us-ascii?Q?+Nf9viP+I/CEULK6zKySogwjsPjin4x1GpXtDjII7Gl04dnkAReBwUBYJ3fs?=
 =?us-ascii?Q?PUI2Y1bWvi3b3MWSQ13jkCrQH6nOnroszgQb96df1u9A4bAm9QdTs8qUCU1A?=
 =?us-ascii?Q?Dy5URD6/2BXtoWwFGmdPZIqQronUpJ/mbQXXBksKu8btNNQLUcGrY8GZz/fr?=
 =?us-ascii?Q?HkleU0HATT6egWx3T2l65PKqWlS2Dv/gBOUiokODQnoMaSbdS8QPHo16CJ+n?=
 =?us-ascii?Q?vtYuI5aM+5YUD+QAa8RWP++hMOKqzwJHGDC6xSkXYcBYk5Xr6fls871ge5Jk?=
 =?us-ascii?Q?u2ZwjWqB0lsaQ+oxKpyofpOVpQcSd/zXVPOoZF4Iy+PvsCm1sMsQyzoV25HD?=
 =?us-ascii?Q?j8xz+jNnokar4iNdhWxYQo1cn2Cd2M2UsMwdkQPqf4bKiy3QWNeRqoI0pHij?=
 =?us-ascii?Q?2Kq1msruol1HSgYrSDtfvyEWwFaP9KjTJFbqxnPzYEE8jQ5OVYol+eCcBrJV?=
 =?us-ascii?Q?izx/toLA7C/5NKmQDtkaCHprxT8jHdkR89HtNJklPBhKGR5fQ7MLvdBRgBlt?=
 =?us-ascii?Q?rJYfff42a4j/v94BNfyysbc4fzbprA/aJBM1FfsFhSU/xXV18HGL49QjFrbQ?=
 =?us-ascii?Q?ao2jt5XmSgdU2yia8W/2r2FPuvoZz/yllyZ32uXA0rJ7aOf0xTGydqhWZJUJ?=
 =?us-ascii?Q?tytVx5cHxFRpoD2rqZrqplYuSBPKvc7f+RBGX3NzVJK9TELk5nq4kZB1325m?=
 =?us-ascii?Q?sGCcW6NL7/dOpE+0ChsJkevlYeVQB8SWcY1z5mgPQ4iMnfc+NABnPG2MZpFW?=
X-MS-Exchange-AntiSpam-MessageData-1: H83cw4H/FNCIvZmKkb5xxyk3u0B2OyraBGE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299da94d-f720-4412-f8dc-08deaa8991a9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:34:56.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjnBXSbiSdhnvQbdPi4Jvyr4YbM4MOpRK6wxzo82WEm0hxZ/Py31EwwziY0046fcwZD04l0qR8lrVOZL0Z/EkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
X-Rspamd-Queue-Id: 8826D4C9D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7487-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linuxfoundation.org,nvidia.com,intel.com,gmail.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,linaro];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Sashiko says:
> commit 1ca88ec2e954b3a331eb5afb8081406d9200c8f6
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> usb: gadget: tegra-xudc: avoid direct dereference of phy->dev.of_node
> 
> This commit replaces direct dereferences of the device tree node with a
> parallel lookup using the phys phandle and the padctl provider. It also
> introduces a local usbphy variable to hold the output and simplify error
> checks.
> 
> > diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
> > index e9d33be028664..cf4e6c87e44da 100644
> > --- a/drivers/usb/gadget/udc/tegra-xudc.c
> > +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> [ ... ]
> > @@ -3515,7 +3516,10 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
> >  	xudc->vbus_nb.notifier_call = tegra_xudc_vbus_notify;
> >
> >  	for (i = 0; i < xudc->soc->num_phys; i++) {
> > +		struct of_phandle_args args;
> >  		char phy_name[] = "usb.-.";
> > +		struct usb_phy *usbphy;
> > +		int index, err;
> 
> This declares a local err variable inside the loop, shadowing the outer
> err variable from the function scope.
> Later in this loop, if devm_phy_optional_get() or devm_usb_get_phy_by_node()
> fails, the code assigns the error code to this inner err and uses goto
> clean_up.
> Since the inner err is destroyed when leaving the loop block, will the
> function incorrectly return the outer err which is still 0?

This is correct, I've removed the duplicated "err" variable declaration
for v8.

> >
> >  		/* Get USB2 phy */
> >  		snprintf(phy_name, sizeof(phy_name), "usb2-%d", i);
> [ ... ]
> > @@ -3525,22 +3529,31 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
> >  			dev_err_probe(xudc->dev, err,
> >  				"failed to get PHY for phy-name usb2-%d\n", i);
> >  			goto clean_up;
> > -		} else if (xudc->utmi_phy[i]) {
> [ ... ]
> >  		} else if (!xudc->utmi_phy[i]) {
> >  			/* if utmi phy is not available, ignore USB3 phy get */
> >  			continue;
> >  		}
> >
> > +		index = of_property_match_string(np, "phy-names", phy_name);
> > +		if (index < 0)
> > +			continue;
> > +
> > +		err = of_parse_phandle_with_args(np, "phys", "#phy-cells",
> > +						 index, &args);
> > +		if (err)
> > +			continue;
> 
> If either of these device tree parsing steps fail, the code uses continue
> to skip to the next iteration.
> Does this unintentionally skip the entire USB3 PHY initialization block
> that follows later in this loop for the current port?

This is correct, although theoretically of_property_match_string() and
of_parse_phandle_with_args() should not fail as long as devm_phy_optional_get()
succeeded for that very same phy_name starting from the very same OF node.
But nonetheless, if this happens due to bugs, I've instead treated the
condition as fatal and printed error messages for v8.

> > +
> > +		/* Get usb-phy, if utmi phy is available */
> > +		usbphy = devm_usb_get_phy_by_node(xudc->dev, args.np, NULL);
> > +		of_node_put(args.np);
> [ ... ]

