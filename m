Return-Path: <linux-can+bounces-7052-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AmrMiwkr2n6OQIAu9opvQ
	(envelope-from <linux-can+bounces-7052-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:49:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B8A240506
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CACF7324D590
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98F2438FF8;
	Mon,  9 Mar 2026 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GDCnNz2u"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9761436351;
	Mon,  9 Mar 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083426; cv=fail; b=UVrUvPawHKijDS8y/CSFMXIRIyhxWSq/ki7i7dmWkO7D/5ApKvauEOu/5mtpgbZR51mmANMtwFDxRI5sJTlr3YfWuV8kEwUGT3G7864qX93qAB22Sx2hKFDn4XrgFQDMBSnTHlsV8j21yZMiwhakewRgm6BVxp07tZyXOFXPViY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083426; c=relaxed/simple;
	bh=U9a7c3sAXM2U6BESvZ0tz7DMkzHW1w8Q6JcymyQpwjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbB2zTME2gk8oAHrepyU5Cv1/9DC+dEsZLU3b8+PgPB3Bo04q+31JrI2Q8DvY6V0TqxRNMF41xLWJR9Gm4tniVu3UnDZ4NxT0wyfY/mpXx7fp7shBAaW4MUK7DstBfXCEGK1IW9UpBks9B2r+4ndlf8ghSSFSragJsF5529pcNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GDCnNz2u; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnMwpcSgviLq/1WmSrqbgaOIiWEAcoKBcEAuddpiCLtpfUq0h3EqvlReJSKlfG6VhQIXEfEfOayKyXJHXtX3uL8yWIIW19OeCaYZcFAC6WAN13RwEZgiadD449IJdibXcKa1kda+8eBRrFvKWNd4KUl0KB1fmvtxtGjkQzmIUHmFJNC/QWTpCFfkl2e8ti/SDciDg54Ete8xyDSYZ6+JWcGNsmZHrDuL4JDfKA7DNpXEejbt7wzaTiH4kwFend0dQC5MSQd+HJeEk/9l+7LZjrfEBjG/PMO9KOdVMb+uXCeH/5HDfGfRo+3HW2P1lUkqYcTwiv6cS2S0oRSsnwPUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4sweO+IwDJ6Ua8w8EgyJVJt++1frmmbObWZL1QvIN4=;
 b=J5ro1Xbpnyo5WjarEekEnuTC7lFx95IU0HX/h3mY1ifSpLUrbrknlJ9cb0ic8h3Z4q4A09tiVyxL0i6rXcIdBuZFLH+uyiuUOH1WC5chpdMaa+UVsZuu9OP2PJ3TPrzvtyCHxj3ywnteblu+i/8Adiiy+MpbDyq/jniJxsB7domaW4HWk9LHEDQA3DlBGTplSiFrI8iJG+/C6gIXc0UhzF4LXv4HOEP5gd/FOgKGMQ1E3jntPAmraJ/zJGaXZlf6dN7/GLokjPumTr0FmLWrz4cZ0xXX8FyyJ/CNpcWpKulN3LzsqvwudgmH+yFvLe5nfzXr2Rlxcf7bCaRSQGDs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4sweO+IwDJ6Ua8w8EgyJVJt++1frmmbObWZL1QvIN4=;
 b=GDCnNz2uEM5AkeKzsGtjPsmYSh4Lg9QL524VRc5b8y17v1vOioCXVh971r5jmwkrMfh0QY73leskxS+2VJIy5KepWNFKKwelbdRRoPma4dp2FGp0maxZ5/+52wdrJw57UVLa4MTpEEEB3R9wH0Qcv1dPiC42s34MenLdEzW65pn8wQmJuQ+9g0NNvVZWmlwpbr7iK9EdysCz4Vkr+sSpQRfrnavzW9BBHs4EPv11tgi9lrzhXJEuoPKwH6w32K7Uot616VmqZPI0enLJhdCQfHhBgcJlaMHk8hW+QLdnXaMjdqg78dtr7RA7c31BzRcUEYxXQYC47iNDrvKaSGfWSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9841.eurprd04.prod.outlook.com (2603:10a6:10:4ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:10:21 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:10:21 +0000
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
	Joe Perches <joe@perches.com>
Subject: [PATCH v3 phy-next 24/24] MAINTAINERS: add regexes for linux-phy
Date: Mon,  9 Mar 2026 21:08:42 +0200
Message-ID: <20260309190842.927634-25-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f93734-23b7-4266-5fba-08de7e0f8290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	YodBqD4Iu6ev7iUPHLtRwmvYLTUOGYRoYNpb+g1HDbPqgfG9p+NZBFOK+50wRyRZCT/JQkOmYXAfXRvcTjr3oBtbrv4J7eYoWlfWz/XQWTwhPJcd8YhtVJprBWKi9n/6RK8tGDeEiTyOaSDd7SGjx6ka4Vub4q8Q/vsJUtzaWSdCxX6UgqlOCW8fJF8qMrWkNAlqzlue7PZy1bzibi5olxW9JHxMRTVMOqTUGULSRuOsDHRhOXwhk898LZ+Dx5iPD7WaVEEqgwsBpo+vyof83LojFX2QYmQXkJkGfoaEXuDIwqC7A1kqPcqQ9B7add6JsSYgQkMeTGlgCoTEJj8fKLmjZZ2xlk3Yi4YgCSAZ/AaTgCkChYe86OmR4HYo2XrqMjfunt8fOY9Qt/94hlVX/RcK0IbKJM8veA2CaVM43Qu+3ttWgrLvVppolnsHVP3qvDh/Jg5zjPCNA1a574oyG3Jbtv49KRaVkd0jgR2nLuqw2jvTOKV0/NL8+kCIcaFMIl/cb1PWaLKEce1N/7Y3inX5qJggjrEcMaSYzc7Rs6ntpHHLyo+xgSbWGcIN6FV6JC02UACX7vYIAMsZIztob/hAujYtj7dBZNkc476JRASKJ23OYNzcnJCTO2CC5sEYQTRWn3D6ufbI50Kdby0bbfmyHZS2bgGJccNBs0EmU2DWeHJatGC57DcD+0WfN3OFsDv0RRvebw03f1oEhGnBO8SY9/fuV4yV4I4RgDoLH+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OgPvXvzXQx2wvsdRhLsSZNFyjENHW1WnSO2+mcYLMfH8X7ZgKtv9KaRFdkmM?=
 =?us-ascii?Q?qKVMDopQrlrP/Om1TGUWT+dK58IUZzLFjxGtRo8mGqiXs+cd1+PY8eDQt0hC?=
 =?us-ascii?Q?Wv9JyK/Gu8LSx6FQ+FLKAdMM1s/JhYIORXpMUKK9nGpOPIEDed4wfd88m929?=
 =?us-ascii?Q?TdsgFZU8zg67b4rTkRLTAmg3H/kpqG8zLx9/esjwakb3mBmj6BZChi1eh5bP?=
 =?us-ascii?Q?BuAqV60phU9cpV5zXeGTrgdtoXO4MeBGbyuHZP64TQLWRAfJUp1jcSGleXoB?=
 =?us-ascii?Q?S6Y8/2FOse+KQM6wiWZgCyoa8kExo1csrpQN6lnUNZFhE7BCEZQINOb8NdzZ?=
 =?us-ascii?Q?75JSPszT457Xm3W5YvSeg5kdZgWOM7WMzPNOPKImoBbQ9r5MqzBVr6MZ1z4m?=
 =?us-ascii?Q?Qdbj1LMl7vuTchD5ANKLcK1ISiAttv7gUxQ9z48ZGuItHYBqEKF9HuESmnGU?=
 =?us-ascii?Q?9ZZih1OVPTFn0Qo5kJfXusKjxMXeR6AlpYm8ag3AaMNgBZaBI+4GF/9yIgjE?=
 =?us-ascii?Q?6IGKD6NPLi9NThah4q+QQka9PiCfj87JmLrhSvBb6SMDiV2MqyJDNUAy4MWi?=
 =?us-ascii?Q?KEUwCzdHOm4hQwt65825x9vWNyUVnjfRjRaJMNlUmbCuiEYR1fFN2dysKN0w?=
 =?us-ascii?Q?j368DswaCCae0J7YzNdHoqQbjB+2oHL4+zGV1bTFsC7zi6lZphEg46JHZn3P?=
 =?us-ascii?Q?kgcdNhAT5qGF/zONr+GXae299irU00ZXx115TDUmSGt3ADopNmZ2SmTFc2IP?=
 =?us-ascii?Q?zywD5jePquF/bzKBTlLq1egTl21X01cQ2gsXeEJ3K0v2EpFKUv4N1yYvNi6e?=
 =?us-ascii?Q?azrqgseRw5xXLd/M+5cml8EpKFgy3O0n7BpL77NXTpf89a04Pk08AR++ykxt?=
 =?us-ascii?Q?lSZ0SJDMR99MRi5WM0hSiCSzNzXtTWMYaSVQFBvrs0h4z4qPDUD4NQJnz2PS?=
 =?us-ascii?Q?ZF0MdAu6wqRS3UP+U4r4S3Ys/FKZCaG2MfqmmVGRDbEftnA+miSksrORtZix?=
 =?us-ascii?Q?QmT7DW/tXwdlAhxhp4Rc+mKqj7v7WBfnTJCiK4y5Z9Yt5hKRLn5tig1j+O1l?=
 =?us-ascii?Q?f0IMRmuzNODJe3kqkcorbu98LWjCkj9l5j31u4mSdkO6pXc8FQ4e8sMioBm/?=
 =?us-ascii?Q?ik51Qvzv5eDihhK1mbTbrhO94+w1C058kfZvlq/W+gDorKYfkKMQVMrvFttY?=
 =?us-ascii?Q?TDw+uXXtTAVRR3NPfGqOLtUaEAzwX7lO3LxbVzko4Ec2qym4CTuo6aKlA2oq?=
 =?us-ascii?Q?npJTw5wKBnB+C5Pmami4/ZU/d2aVI6ZiKrLAsaNr1Y8MMTxVez3YEB12OLGJ?=
 =?us-ascii?Q?rLtr7v0ptDh1FKO3SFRP8cknFBPYEAatgRkDIvRYy/JaRruVMYeuny+n+lUA?=
 =?us-ascii?Q?EgcVvX474sZvDULCiL+qX7Rg5g8rkoK6Q5wT1Z7E/BTZ09TOV+rBMlX/qdHU?=
 =?us-ascii?Q?yd6vHL26exnLMzey98Wv1NttLpO4X86f9uFGJAxH1jKcG9Z0pohZfRm+fHoa?=
 =?us-ascii?Q?cO8Ghtw5+d+f4aJdOakkg67OH3iVNExswp6IhwYey9zQ5DY2ildhCg1CZ2Os?=
 =?us-ascii?Q?f050IUzEPu9EqtYBYx975Ov/9qRaM+xFy0FlF5WjKuJAXbBlkHT2Sls5HecE?=
 =?us-ascii?Q?DnfWGYGRx7hzjlDX/boDQM85maya5v6z6rqQRJG0lfVR/CvT95XR/yAkVGlr?=
 =?us-ascii?Q?M6n/jq6rYgOgEvEGtB37zkLAUEgUo+BkoW00jfWcVeqNqxFQZAeLRBQhz+Au?=
 =?us-ascii?Q?GcPwt03+CKhhSiyQ8KV9VvjMYi0FSKYWCars1nCUswAAYG+NmMg6EY0Cgxs8?=
X-MS-Exchange-AntiSpam-MessageData-1: A0JbZHFZBGo58aq+2ElG+BY3gi3eEAlzoyA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f93734-23b7-4266-5fba-08de7e0f8290
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:10:21.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzAzcF7eG4iHNharFZvlsmrqc/lQCay1RuJzZa0WQQ2TZpifiiSPDT9Rut5eCG5e9GixLMiqP4ciQtbMFo3yew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9841
X-Rspamd-Queue-Id: 34B8A240506
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[perches.com:email];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7052-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[nxp.com:s=selector1];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	NEURAL_HAM(-0.00)[-0.983];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,perches.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sang-engineering.com:email]
X-Rspamd-Action: add header
X-Spam: Yes

Some pragmatic shortcuts are being taken by PHY consumer driver authors,
which put a burden on the framework. A lot of these can be caught during
review.

Make sure the linux-phy list is copied on as many keywords that regexes
can reasonably catch.

Some considerations that led to this solution and not a simpler one:
- Consumers may be located anywhere, and their file naming provides no
  indication whatsoever that they are PHY API consumers.
- The network PHY API has similarly sounding API: phy_start(),
  phy_connect(), etc. Similarly, matching on "phy" would hit
  phys_addr_t, "cryptography", etc.
- The header files themselves need attention to avoid matching on
  include/linux/phy.h (network PHY), include/linux/usb/phy.h,
  drivers/net/vendor/device/phy.h, etc.
- At least for a transitional period, I suppose developers will still
  try to add PHY providers outside the subsystem (which is discouraged).

So I used \b to try to match on actual word boundaries and I went for
listing all markers of PHY API use as they may appear in patch contexts.

Bit rot is a valid concern. I will add a test to the build automation
that newly introduced struct and function names in include/linux/phy.h,
include/linux/phy-props.h and drivers/phy/phy-provider.h are matched by
the MAINTAINERS entry K: patterns.

The keyword patterns were written with great help from Joe Perches
<joe@perches.com>.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Joe Perches <joe@perches.com>

v2->v3:
- escape forward slash in linux/phy/phy.h in regex pattern:
  https://lore.kernel.org/linux-phy/9fd14d166e860f26febfbc9061a6dcae6a166961.camel@perches.com/
v1->v2:
- split into multiple regex patterns
- use matching-only (insted of capturing) regex patterns
- adjust commit message to reflect the Q&A from v1
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..cd920f14abde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10713,6 +10713,17 @@ F:	Documentation/devicetree/bindings/phy/
 F:	drivers/phy/
 F:	include/dt-bindings/phy/
 F:	include/linux/phy/
+K:	(?:linux\/phy\/phy\.h|phy-props\.h|phy-provider\.h)
+K:	\b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
+K:	\bphy_(?:create|remove)_lookup\b
+K:	\bphy_(?:get|set)_drvdata\b
+K:	\b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
+K:	\bphy_pm_runtime_(?:get|put)(?:_sync)?\b
+K:	\bphy_(?:init|exit|power_(?:on|off))\b
+K:	\bphy_(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
+K:	\bphy_(?:reset|configure|validate|calibrate)\b
+K:	\bphy_notify_(?:connect|disconnect|state)\b
+K:	\bstruct\s+phy(?:_ops|_attrs|_lookup|_provider)?\b
 
 GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.43.0


