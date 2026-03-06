Return-Path: <linux-can+bounces-6969-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJj7OuvNqmkNXQEAu9opvQ
	(envelope-from <linux-can+bounces-6969-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 13:51:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA2221044
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 13:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B00F3020E87
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F5390223;
	Fri,  6 Mar 2026 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ja57YkRc"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE48386C1B;
	Fri,  6 Mar 2026 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801510; cv=fail; b=LJToVd/tMM+0E3TSTi4ucCMHt6vau9MrU1l95/ILGS2Gm0FECJcnfWJ/Z1b/DaXq/Ume1utTlMxnUE6SL9cavYQO2ByaiEJ7zGHru8iWuHeXD4EbJXNlhYgB85gUxGyjII2RvRTeBbgvfHF75wXqaXVhnDnCx/I9qVPRoovawf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801510; c=relaxed/simple;
	bh=qQ7sFQxhfmBjvK3BF+OY/3vWLaVD4k6jIYL6pTKvpls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NN2pUXcdMuQ3AHzmrBnD+Pz3LdlVSLW+F/YwXjm0QT4wcn29+Sglq1sgZPxmKUpTWDfVris7ujaDWQwkN6xDkQktOONk5FqVdOd6cITEL0MbeqD3AM+KNkpEnDmrdgaqSAEvygpQCBeyYejWTvWThcwT9M3QvpqbpDRBwIxan30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ja57YkRc; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRru9RzQRSQit2nlJiGEbdY9mNODclGZDnH+tqAlPmd8esbA13R2U1aN4iIo0XxVBgqKvyHL022m5aTHwRWcURO9EJF3Ov1EMO5W05uMmVRkVHmPoxMCMFU2Kz0+Xo11NVdckD7saRONnW12mXc3JEdkbKDvNvPY5zkXFVmQRO1DHz0YlRik8o3JH1XtGLjLpjZtu/v6Il2/V4E32a7vFyzEbv7Hs3NDspX/tY+ncWMchLIATd36Wlqy3QZhX3wddqhP/GjU6J5g9bcUNCafZVjauohAR4VO6ABNRDtvvvbmBtkLQTmehhVKKkMN1SVnHJSGO0oZg4M2H8zRL1GIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+A3sFoAWcIMESKa24zpR0X6tEHYzott5WX/3qcKZx8=;
 b=ybY5O1opTvhWgKQ3fZ7CC/GFW65CA+q+z9bmO/73fW4t8OkejLtd2zt2pIbCaTiQyNSBawF/v1VPj9dXvejMeLYHO86MWB3TQ9ewlW0yPV9B3QoWLqLBCurMQY1Tn17PZCqUK1nqgPXFKeZPfNogVPuADTZvbF9q94eOqSPW6vnjMZxdyUyIIC2cmuWKw8qk/1n6xXowr32ulZ2g+y3SbEai4tAogQoTMq9GIREeYqIqLT2ToPn2b7vYr7RDaVs6pzBioc5CAAF9zGVwyP8v5AYRd43tINbfxnORY6tjgZcxGJmguiGPsvEK0alKIa6gtw22/U/uZJG/K8D3tE1Z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+A3sFoAWcIMESKa24zpR0X6tEHYzott5WX/3qcKZx8=;
 b=Ja57YkRciojLh/zyqVUKArMgav3i8mp1JtjYRimEl7M92vmVH7+eqjQDGoAbG/PuXZFmIsQ9vo9XuEzCfaSTf/F3QzvcPwFDUkZ4HQo6yYXakMYVmhJlySX3YCj/sHUoLGanoNpTCOS0B9l01cCTeO1f4rVnzcdDJl35POK2+Iv9on3MK8eFFw+QOFO6m2du+RK5FVP98r1qbFH47fdQ0dgpSxIqQ6cW8NoH2MSZitehla9qqVfMzFYl6BDrSNYJepCkt8n4eDsX3odmsoLP9sCuxxyEvHLIjC/TZkk5SENT7tL1hTZGGy4ofllZeAw0+aUa5LL1ztdrMunvtSwMBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11670.eurprd04.prod.outlook.com (2603:10a6:800:2fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 12:51:45 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 12:51:44 +0000
Date: Fri, 6 Mar 2026 14:51:41 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH phy-next 12/22] phy: move provider API out of public
 <linux/phy/phy.h>
Message-ID: <20260306125141.cwgi4eyp7t3aioef@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-13-vladimir.oltean@nxp.com>
 <CAMuHMdV+7n==crPmitH-JCwtJiH+7LaPKZQYU4ZqX_duo3_7Eg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV+7n==crPmitH-JCwtJiH+7LaPKZQYU4ZqX_duo3_7Eg@mail.gmail.com>
X-ClientProxiedBy: VI1PR09CA0141.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::25) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11670:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fba056-b90e-4555-e3fd-08de7b7f1f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	vy+xaMxet1cOCBvjpWFOi0XDyEbghWZJQA23SfqtgMD9WeW345m6ZbDhLAJKIT5ZYBxr5pGofiln8qJNmtftSlHAPZxlo+ua2cp/wM8XF3MqXQa011u/lZigRvVZNIFR1fl4BGQOGt5eXYD0DQaLt9J4eE6Iuaf9NzQtsP2Jbmll7i9FBzZR0JcN6VDEY8hu1e9JjTTRwMGoUudcLOic5TWEKGLn3yjo0qSXH0N29UA3dHh4BBzqTdt6lwLj4F7YlWEPq0ePvlQ7jjzey78G6IEK5LXt7VLNq7Rph/6r4goFnpgTQZt/pOLWBDegBgHY8lU0CBWN6ECG09uVrs/ihZhlZ+GVSfi57RKveWNI+0htMhBbbQU/OyqoDs7ElythWduxtjJAKfE+iDCIyb83xEBnElLCA5ubx0R7rSBNE2+e1MPMAwJDXCh1X2Ifc/+0PowsX8A6B9q++OpZHN3cGG19TibTv7PCfjQfAqrCRHVq5gj6K8HPtqzwDHiMj9gBg1B53Oi6wGxd/HPBXPKJ4PzcRpGmKWX7KITfcf8wiahDgPiyhOVukfV3Kw/TFpzFPQcF5J6eqEq72osvj5HFaetTs0Lw9Uyw4uob2zYzqLqCFfJzAjDYgejtSJPdeQCOT1KdSMOAR7aaELnPR61nHvKqGqEn72nblF8KWLMunlrMVfRdFmRUvwek0TwxgMyctZ5UL+LK1POH51fDeYi7Mxne0WW4wuxaJN3WHHd5l0U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t2wPMiptX9Yb69AogYYNUM55Y1jrFaIojMupqVVEeWdjHUsuIb6cWnTDlWfG?=
 =?us-ascii?Q?sT0xhfiQTn82bcPmcYrtceiN0Td7U/pLn3dw8ETXor3TbyQ0HAZ3J4jOpBTP?=
 =?us-ascii?Q?ADEkQSMC6xt89st7QzfBEmEd9xTYQa8kXErNFbhIIDh0Hw+kxJL2Ecoesgug?=
 =?us-ascii?Q?TZvgPKZv10S8sCofACIJU4f0gIlRxu1l3dbee7+i1hTH0veFs73wNCisfsrc?=
 =?us-ascii?Q?Oc8Gg8+rH5Rtpn9QhgbuvWq5VtDG+xf5twzaaJzU15icjcyiN/8M/4+u+uBS?=
 =?us-ascii?Q?uGdJab/sTeiAhxbWyioq0lXORh8wkZHvmhXbcVYzRWLUsEV6aVm9xTv7D75j?=
 =?us-ascii?Q?z7H4QyYqlcoyCtHvNcVHtzSqu2Pb9uU7c5bZj1Ygr/OTvaHu1kFsMQWbHxOi?=
 =?us-ascii?Q?BO6JuogyiibeVjttDF8LgRg6iFEQT/87e9AqQLkgRy4UamEkXn/Xi/whIxu9?=
 =?us-ascii?Q?StJaBGGkvDQkLOrTB5Mgp3DxFv32HXmhF60u7JMiCfWKXxnHJE92GAcgi3be?=
 =?us-ascii?Q?MU2blnma4DpXI7xRKoW4i9e/zqQNgygWvxsXnt+0oGffPY0KxD4MwjSP4eT9?=
 =?us-ascii?Q?1E4lrGX2z34hUJZ7HLNamV58C0FnzSpN3CGZjvHQ5yYRRT5dE576CEi5LeLX?=
 =?us-ascii?Q?/Jir/FxK6G9nTZfeZxdFSMDvb3Xo/3fLsBdkRCFlYtr2LfMEuaKqt1XW43p1?=
 =?us-ascii?Q?oNc/L9tsy7I+aLVvNCJR1FtQEJHRR800WUqOJpu+M7khEuQrGFEEQ+X8Avjl?=
 =?us-ascii?Q?F9wxmqOEgy2ZrxUcpwacV/k1ef8bmVUW9bzcoLX3HucV4BQPW5vXvXyL1SIj?=
 =?us-ascii?Q?YrfjliAwozXcmlqi8RreWi1grLT1VJV0U9a1T9E5pYlhn9erkVTKXJX8BWbh?=
 =?us-ascii?Q?vfLUorpjKgNTpjtVmCmRgOUim2aESm4jiKCAlBwXyRRJiw/d0gX+XyDQ98LF?=
 =?us-ascii?Q?p+j7LR4JiAjc1BrZM+MzpsrM78iNSO2pyk+DLPgtsbrrB8CP/VI8/jloS34I?=
 =?us-ascii?Q?K2MeclyL/8DggGITX9sbCwCeNRjWAzG8z/X+73Imvii7HirT57CS9FV4GtCK?=
 =?us-ascii?Q?KQDuy1u3oUZzC4Jda419FRFJLWuA+J/bbTgdjhhuzk2DGUH4hVEEJ8Y2bGdc?=
 =?us-ascii?Q?zbdswiAMd3JGc63YyxPpoOgYacSNnjiS5gt3xge/9i7f0tOUrWMXBuxQBEZr?=
 =?us-ascii?Q?NctrbF1GQrWn/seszf016y73Kf6z4RaGwXzV2gZ6rHDs8S08MjAs+SYRG3IX?=
 =?us-ascii?Q?fVEFOGokrC7zG75Jsj2R6clA9xSLjbAGtGNLDNAYyBXpqQcnJVtZPOiwvBoh?=
 =?us-ascii?Q?atYbuZlbC6P35W9SrRAEq+mUBXLDXFw4FV/t1NgZeAlua4eD/8pwu36O+T3V?=
 =?us-ascii?Q?thTxdssnZvfo8sNztFuX+pPF+7LnAzhGFRkTNbPPQeqAwlpSXNzv9RvKnfol?=
 =?us-ascii?Q?hjiXRmZUTwuVf7jJCMj4lyRdiOFeEGVIW3xhDkE7Y+oc0XKmWtCo97caXRoE?=
 =?us-ascii?Q?qn9zxgGS0BVEYsQRgwPzIAD1l/4e1s1i4oMSAQfM869A5xsnhUVwTSa4v6AY?=
 =?us-ascii?Q?3E8nc8EHHUZ28UGAIa1z5szI12HTNhDcIajCtIGVZK+2dskNkEfhZyKRGTj9?=
 =?us-ascii?Q?Maxejo+tKCUopZbhtGlVndVS8rCxCI47e/qeX+xL45i+HwgKJK75Viswt6/s?=
 =?us-ascii?Q?qCFY7/z+7uw3NTCJIDQAE/8q56HojejfJfFLTfTP23BfiM33JUX++Ev2MR/B?=
 =?us-ascii?Q?QMAf2s+QhrR06Zyx/imw9TEZNz+KaHCFkM67nQHNWlrd/s54A363NCeNQRdA?=
X-MS-Exchange-AntiSpam-MessageData-1: +2O8BpnsXpY4N7M5oGcty0iT138CaAT4Vx0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fba056-b90e-4555-e3fd-08de7b7f1f04
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:51:44.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipVZnET7S2L042iT70mt6YTchi9j2mPmp/d8xhBLRQWP0WuabYdGWbwNUWes/H319X3jvFGlrwrULCwVmSTVjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11670
X-Rspamd-Queue-Id: AEFA2221044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6969-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:28:50AM +0100, Geert Uytterhoeven wrote:
> > +#include "../../drivers/phy/phy-provider.h"
> 
> Shouldn't there be one more "../"?
> Interestingly, it compiles with/without.

Thanks for the observation. Indeed, it compiles both ways, I have no
idea why.

