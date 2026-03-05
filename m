Return-Path: <linux-can+bounces-6930-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GzsGktJqWlZ3wAAu9opvQ
	(envelope-from <linux-can+bounces-6930-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 10:13:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D420E147
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 10:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E981300BBBA
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BAB377005;
	Thu,  5 Mar 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dRjRcQZ6"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63490146D5A;
	Thu,  5 Mar 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702024; cv=fail; b=mzi5fXUa4t8xnlcmOr7geGFDQZZpHxbLfKJG/k36bY4xWubW/9G9w7RJf4jHbIta9ni4OwC5nGUE8LpbK1fLQWF/U6UNUeNkx5jkCAQNnnVhBVN+scteXwOWw6ltSaj5Lhsd/oatG2OMVMkmeqqeLHkrQaWpdA8aPR0Z9W28j00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702024; c=relaxed/simple;
	bh=9FPOKILEipkJKVY6zGzoN+cWyjKneMsZzkOxsblpuao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r8S1sOWyOV3Qkk/JHEFbmP1jl/t99a1xJm3aHW6Cu28s2FOSbd/NeQTpGzskWGo6iI4S79weNiLi+ow5bOGuoR8yfKV2XuoQXK924yL2GmJdvtGKG05LdPYmHhH5zaoy9ODKqh5JdDrZOHa9vsYotX/j30Y1dLrpCyangswgEQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dRjRcQZ6; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5YqVzmk5ipSgSmkl/SlGsMORyPqrAMNzrTiFT48zMrIewp2mhJLyiBKPmaSDMVLBPl5q0tDb8o7QYQRHxVMiEDlO2jTg1n+mVkeyJftxdLOMAjb0zZEd88eeUYs0nOBEk9uJnDkrJ1Bh+tkbwN+lphvqf6DaEuz8LDyGVVVGwxzHzQYzmOrSrf6JeX366tFf0GIHrAMXpwdHsQ1dCT4ITY1y1kDPjAQIBJshfWJBZRwlcEENY9OQiVqjh/mhypVX0lxJLjtUbKdR3q7OrhKkzdrWZN7CSJ+gB+MrDMxIZLMUd3t4929J48muw7MsN+Adnwra0MYosYxRCo54LvDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkFm4cOy2wTBlaXyBbVBfTP2/tAGbUuNaBqmeS/09Vw=;
 b=V+DG8rczpElp/b4TVRdl9ky6nqdT+lV9uBkvg39ymsjWeW8Nmo60ekpCXyxszp1sHqzrm9P2plejGUfiKc2nMzCrCvgvW94yCzi9pgwVLtCAxlZfn6VIHtertGFyosVPXeS1iDlAW6sUVEUVr8KgZsWuteuJ/O9OZTgT6l/N0++mxUbpKpwTO12VHXnRMIUo8rOR5RaqaGsThATuYAKjtMG3cfkSXwkW1C2o4KLP0x1AseA7WOrcYtSHpa7rQRoSQ8WBz28tY7ucL9aaJM5OwQy8AwjCkCbWudWP2kxY2F0aLB/swb8+I2Q18iMDo0MCvYEJCwyX+VypJb20q2Dnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkFm4cOy2wTBlaXyBbVBfTP2/tAGbUuNaBqmeS/09Vw=;
 b=dRjRcQZ6Hc4xakPYeE6LrfXb6Lgf0UvcjdLB4bnHHA1z/OBWYPDyRNhLGiz0fXEZv/OtTdzcI0lub/blKSVeWGLXG9bi/9TjuLxOWhG3yFIpnRXDpvj4BDEadsXWxVTdo0xNr9xRn/TF/44dt4Y8uMQhTDMbUBwvaLDGw/Zvez5oBTu+2zMB8kNBJY6sYctWVcTty0cZANW8Np1YUvoDNGmIGYpF6HSSpCZSDMZve+i7qNQpxTV+0ACtK8okd+X6Jd9sdwyuVlySLnJtQ7+9SDxcyGdz8Kuf1wtUE+8TIq/AqgnWzd40Z5oCh0B+hwa7xnpDNqFLV9rnX36J9q8Kdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7896.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 09:13:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 09:13:40 +0000
Date: Thu, 5 Mar 2026 11:13:36 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305091336.ls3k24ieehntxf4f@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <ebee2fcf-9069-4a9f-ae72-86f4471cd4f3@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebee2fcf-9069-4a9f-ae72-86f4471cd4f3@oss.qualcomm.com>
X-ClientProxiedBy: VI1PR0202CA0009.eurprd02.prod.outlook.com
 (2603:10a6:803:14::22) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 1230313a-be16-4660-d807-08de7a977dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	D4zPoLN0updlww2q42yKUXLpJwUtvZeeYVzDxGiPfrCHA22H5oZxLEZKYQ8+1oVAyHPLfcSwKb2A62jymjhAcF+bS3ALZdT5/o9ZWsA+iZw0JgERjtgaTaokjXpenZFgIv0TDGw0HFkJ+d67pD78CB09rUlI5jjJcVB7iTOjkPYqc5afoPRONynnPU53t+c/rklhZ6yFfBBM6UsBjIB9xvX8H2ejd+gT55RdAr/ERoAq8/ONoM+2+9vMvv4ZVFKu5VlwLEZ4jsprAl10o4dN6U4wTJCMdvAkmrkVLYPwltALRe9UvCBEqDQ94nWHIGKGCPA4uTnmFfvcjGLR7Dw8kjmTaydmIUFak6BlTNty4u/3wV4ozmH2ItUiUv7PX8/i6po+hrhmnqfGjBuP2yM1amCWt/bgakd6gUbP/tPDI1ZUYsshAd0DFWAKU7E9WSPULF87Y0jGA0MB3kWlsf7Xdb4y2qbXlPwaPdxK8kyhVm8baZ6VNj7s2Kjy2XfQi8C5PHl0jqubcJXC7Zxm51R3YKnyZnEBIGmVYYeUqWLUyANLh8PmRwd3Yo5fOY4qyXL3mSDWgvjb1Np0Q+9avWwbyNbSfKv6vjNWrrksu+nLkIZmppUIpUoonSXbZHV+M4ARJR0nmvgsnoYFi30bVovXqF0Y4ot03XH5xVPjPxNQTCcoGWniWIFsuYLCfbUdn5FPH14TvC00RczkF+d8ZNp4mWAN3u5ZcLKhZkHIz/2f/bI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NlwVAWYy7PleyF/x2ThwqxQn+22MYhgdSDLyzuVXMTDKdgdCHqll9wBBl43+?=
 =?us-ascii?Q?0t71CrUuNVBnllbYM7ioSyx9UpnwfxCgedSashB3bazf0GVdmUdbAN1QU0x3?=
 =?us-ascii?Q?vucBTNGhyTF77J2/UDMdbG5g7rhkq5x0rowJNxuOSV3V3INeeFhRu0ozEbEg?=
 =?us-ascii?Q?Ve6CvpYVXdGKa1btpAnNMwNzIzCPZR+Kp5waUZblkczD4ndnXg7maoQsIlrB?=
 =?us-ascii?Q?WIHVNic+ehz3flwxmvfg8TvUFK6OttNzs9wMqISLHqx9Oxa+qYy6UZN1CPuc?=
 =?us-ascii?Q?iAoD1zhV/Lg1gaRS1w/WuwhTyD3kO4nkp7/EkIajL1q7Pb6xxUlhF0f3gt86?=
 =?us-ascii?Q?V+bDlHb8HHQYanI3Lrj6SuUJjwGgEiU9agCs8JAvAN1YxydVBqhjAR8BHkro?=
 =?us-ascii?Q?nukTTR8YutItgNfjHZjXtqvm5MBPwMzHFiPCk7zi5M3xQrP5Nypo1U+cXDJv?=
 =?us-ascii?Q?ckoUNk+Kk/ACjiCY9NE6DxrIJ91Sh4IrFUSr9cYX6JXo0o/skEDoS7cW7dGm?=
 =?us-ascii?Q?FfFN9mQMeczvv5kWCHf8l+5W7/vSxzIommZrjIQA+72dfWMgFJqo+H/t81/d?=
 =?us-ascii?Q?6mG8OmgYK/dKpO7BVYhA5D0+Z1viU40Xl8bMbcKm8ToJadCZp2LgXw1bH8l1?=
 =?us-ascii?Q?G/wRFUWQjsppvq0Z92osfjtE1jfhtI+EEsxCJK+f2BYAPAGuYA4cauWEeU2D?=
 =?us-ascii?Q?2exKPYZJiAijX3mP9PdIpP+1hJGEDrPuN1UfM50lXQcLOpkZBPKeq4EunmW9?=
 =?us-ascii?Q?tUUUra/ScK8RumBfuYO/cRQAd5OSqz9wTmUWdVqsRxQ/yO5qRHP6hqBvervf?=
 =?us-ascii?Q?PRAXgIMy8l6fitf6ujHn/jPkZEOiecZfqAhsa6Av+LWzCES3lr96EC0jRAsW?=
 =?us-ascii?Q?QXjUZtNcnb8Aw4kLGw3q26hQBxO2tY9uoiSc8Tb1VkbmGTYXVuHTfz0Yq0VN?=
 =?us-ascii?Q?pjUFmPIfh7vauuQ5T9cU5F+9ICeqvGlW/8IckhjnOjdMsO9VVImDvRlaimgA?=
 =?us-ascii?Q?E2o17iDdc1d9O9jnEwJ/0SXcjAZlel4DcMd3fTPMTRlmaFQHn5QY8DU07M9Y?=
 =?us-ascii?Q?t/elIDUms/iRbpT4e2r3R7OXFgDjhkCs+/J8K+zL+rDMfC4nTxe8btpBQ6ZY?=
 =?us-ascii?Q?03Pe3AGDsPPjZAMnAPnXr9+OMOPZGstWBAPptBkmmuWlQMs8mcdxaRW1+j2E?=
 =?us-ascii?Q?G1/oXI4gXphcKej3a2Lp6NTBzJf1+a+vQfaeU5TENK+Ln4aHs7nRJ7A/HL7n?=
 =?us-ascii?Q?al2GT2NGceHgmqjQTQ298/+sRq7vppOSNYLzBm5Yf8dh6KhrqqbYOR0XYAeb?=
 =?us-ascii?Q?u+WCMDNoMi8si8UFZSoo7KCP7LwQv9IFvyCtZsBLVhzCy0PlR8f6VdGmxY/7?=
 =?us-ascii?Q?xZfhfUwSiReJsma8VZp20LCplSdxPSNtt13Pde+XWePdpaMLqSQatWBJMcfq?=
 =?us-ascii?Q?pHQW+cO8TP3LLBAdcA1djwYaXlFXZuQZZMx7tMZvL3L+VGXkyYxb5pAVSAMn?=
 =?us-ascii?Q?DeMkcbHI2PX/dpm1L+mAp4FxuVohYXlofWBy44sECNzUdkAF+RoUCOAYukD1?=
 =?us-ascii?Q?a7HsNAeeLMVz0QbLX1MrQq9y2GaLtv4M//rZ/0FOoCFll9oXts2Qg6/1viau?=
 =?us-ascii?Q?NfJXi6mGo1f6XcSeAG/4D+3YG6CwOti+oFiBP0GcaXHKs06oLNGrCZKacCxK?=
 =?us-ascii?Q?4S3FGCmqTdt44M0o3GhJULf9uiL/dHURJhklCBXwVm81JO6wyTS64rSKka/W?=
 =?us-ascii?Q?xMDLz+3ouO7Va3nhI8DHOTnvuW3aK6PhU7QfbQrf7s2RSpoNKDVB7T4Dnxo0?=
X-MS-Exchange-AntiSpam-MessageData-1: jENNtVsibWfqG7eRkBQqDJsuIooYgxJlLjs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1230313a-be16-4660-d807-08de7a977dbb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 09:13:40.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0OhWFX5SD/RWpk5aXcgrN5HGGyc/b0xMzfmRBA3CzZSmLWhfA7OvS0tQThpbI8FIbyrgPwhU+/B8M07pHV1bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7896
X-Rspamd-Queue-Id: 0F5D420E147
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6930-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:11:32AM +0100, Konrad Dybcio wrote:
> On 3/5/26 9:51 AM, Vladimir Oltean wrote:
> > Hello Konrad,
> >
> > On Thu, Mar 05, 2026 at 09:39:35AM +0100, Konrad Dybcio wrote:
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 55af015174a5..bdfa47d9c774 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -10713,6 +10713,7 @@ F:    Documentation/devicetree/bindings/phy/
> >>>  F:   drivers/phy/
> >>>  F:   include/dt-bindings/phy/
> >>>  F:   include/linux/phy/
> >>> +K:   \b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|off)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvdata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|state)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\.h|phy-props\.h|phy-provider\.h
> >>
> >> Would looking for the devm/of_phy_ prefix followed by an open parentheses
> >> not suffice for the 'has function call' case, instead of listing all
> >> currently present exported functions?
> >
> > This would maybe work when you run ./scripts/get_maintainer.pl on a file.
> > But I would like it to have good coverage on individual patches too. And
> > since the devm/of_phy prefix only matches when you "get" the PHY, not
> > "use" it, my fear is we would still be missing out on the most important
> > part of the patches.
> 
> But that's just '(devm_)?(of_)?phy_[a-z]+\(|includes.h'?

Yeah, but what about the networking PHY API, phy_start(), phy_connect(),
phy_inband_caps() etc?

