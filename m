Return-Path: <linux-can+bounces-7663-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK10OlBJDWpEvgUAu9opvQ
	(envelope-from <linux-can+bounces-7663-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 07:40:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F39FE587D59
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 07:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B1D13023C38
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 05:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46E132B114;
	Wed, 20 May 2026 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZAO6bCI1"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010005.outbound.protection.outlook.com [52.103.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DED1DA0E1;
	Wed, 20 May 2026 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779255627; cv=fail; b=neuoilkPhf3LOkH9NbcFok5ZYFbwgI01NptrctzUIouQ/N+wsh5A/JHAvXcXtFQ9JdeiAbPjVUXQxpUqJz6D/khLLVi8BHAVo4VqIm6vRUYsxV2/UqJAbsizVvLL4cPYuWK/maJPoQha6UQ+N9lH6rTOd3ecLmNkEuZ9PPUAYu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779255627; c=relaxed/simple;
	bh=BNtiVBW21Vjc234+Fyre4TqdZd0zzxj/7MiaahvDWyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWiMzLB/uRj8Qq3plM/YIKm2ijgz5JoJ/COUEL2MFSAzYilL1tCx27zPDz1TlAkynCjfY5NQXOt+fBZGfU4NBlyBxBuvp+8I8/qmjAvNBtWNAdco+1vAsbAj1zUd3dNNbLfontUKXUKxUavwpx7Hv5Tbpjrh1shPmwAb9NwpxuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZAO6bCI1; arc=fail smtp.client-ip=52.103.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhdSFpuoi7uk83mFIKrx/4lLSiAFYHK+l2DLyAbIl0MEhK7jU9VFef2Zhcpp/1nuJdi4DufS/1o9hKs9rImkXhlx0oPKBJDChMRjKHW3+4c9ClSS56wA/KgIeOAmVX17rrDW/F+Be/dRiz3KVX2wquodZ9rQEg1VgqwKcDmujwdlfP1VIJF/CO8aVhB4CHJLZDvzA5x+DefyXnaeQBr+HWrSIHcE2SM6N6lKbJdzGuYM7ftAPX+NVnmHevNLaxeb1+W1PhdV7Z2v/TNSWIfO61auyBh8mIIMasQlN0V5tJyIE1YTh6dzIom07b7ZTqXX+Wm2bSLN6vuh+P9naOfmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsWydDjLkkAoqp3R3b9Tf2sfBiTimj3Tzg13vP8SxWw=;
 b=imLT7ArW6IWESGV0tDvHK5wptjaylYnXpx90yVht2nZ9lJu+rdPSKQGY60vUzYJViRRKVkGPlDfc24TYXuAnop+ag97o/lxrkkmtlSN1ZyYBpYT6ReatrtkxTRjmHEqjBuNe/B2MVqaLQCvhhZGkLhkCx+6DZOB6vnY/W4PG2cYrKLlVtiA5ptsmcYogZCC/irMZEDeliY+XFKRhFR8GFG9PbowrjtcDU3ZiITPJP4PxqHyPJ4wLxQzDt+QW7prRpeyy24htwgNPKlwpEE/OBDaDVBPUvamzl/89pQV70+4EbWrAhVkd9xsQSlAkyY1CzUhOsqaFCBsFvxbt2ZGMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsWydDjLkkAoqp3R3b9Tf2sfBiTimj3Tzg13vP8SxWw=;
 b=ZAO6bCI1BQn1N0p/viQaDpAQl8r6H5JBAg87ycexYLv8PX9Z7+XCBwmP5SSV8tBa8PaWsBdb5NmJW/9Dfc2ApUDYpkKC495PhviGt3y8ho9yqMmd3qabHWzbbWtZ5/AmzRkOHN3CxZgvNj7M955oG6f6dGW6lJhwkedprI4t555r+k9xY+NDJyU7qbJHaW24H3RHa6UN6PcN6EMxN4Jv69drUUI5cFg5XvS95A7LBHWJF0CDJSTnsUiKkuL7iTDZ69CfnYKaNe2p5V7Wa8nZh0iJU1iZuGqpt6JWkUBniZUfybxBizIBBI+/qF1iIkokunl/ZlwBPgcXZw/gfbFgAQ==
Received: from TYWPR01MB8559.jpnprd01.prod.outlook.com (2603:1096:400:170::12)
 by OSCPR01MB13379.jpnprd01.prod.outlook.com (2603:1096:604:335::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 05:40:23 +0000
Received: from TYWPR01MB8559.jpnprd01.prod.outlook.com
 ([fe80::9c39:42d9:c678:8bfe]) by TYWPR01MB8559.jpnprd01.prod.outlook.com
 ([fe80::9c39:42d9:c678:8bfe%4]) with mapi id 15.21.0025.020; Wed, 20 May 2026
 05:40:23 +0000
From: James Gao <jamesgao5@outlook.com>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	s.grosjean@peak-system.fr,
	linux-kernel@vger.kernel.org,
	James Gao <jamesgao5@outlook.com>
Subject: [PATCH v3] can: peak_usb: Add bounds check for USB channel index
Date: Wed, 20 May 2026 13:40:03 +0800
Message-ID:
 <TYWPR01MB8559DBAAAA6A7F410400329CF0012@TYWPR01MB8559.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <TYCPR01MB856782BAA657447E5EDDDC1FF0062@TYCPR01MB8567.jpnprd01.prod.outlook.com>
References: <TYCPR01MB856782BAA657447E5EDDDC1FF0062@TYCPR01MB8567.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:208:32d::15) To TYWPR01MB8559.jpnprd01.prod.outlook.com
 (2603:1096:400:170::12)
X-Microsoft-Original-Message-ID: <20260520054003.930-1-jamesgao5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWPR01MB8559:EE_|OSCPR01MB13379:EE_
X-MS-Office365-Filtering-Correlation-Id: 7396374e-f2e8-4cd2-ad2f-08deb63248fc
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrOxZ+gpMXNOmgIirVpNNBmsZ9EUUfNKFrIHvGljAzNp7yV58HREW25klW7FlZb1iSJVJzjfYOwEi78Sysyro7uFK3KC2wsPQGDFruPAt86xv4ofYx6iAIwh5CHf5Z+aVDKebxylkpKFsZHGSGwhqTkWo8DV7qFpv0xKfA8ImocC+8rI5SV+V43BuDaTL3r9/kfNivjQwlWegf2PLZCUyEcM7XIv30KC4ONE5yhMxa9oAMXOa9o241jg4kCr2+JbysTt1hf6TbLRJDsX65Rb/shjwX/c7VnbGNvY6z+MYEzUPVsalG+cU5cyddwi+sBN7exowkX0M0uFD1zRIiM0L5x7cQuK1hyZcoIFRRI89rD28i7rKL/5TJtuzi7zB/qrDKiyuxki9Y4fhY1mGpGoGNZOfPOoLooSAp7aiU6FTCnjQpG4QsRsd+snSH6WSPUNUso+EO8Me+0N7udKeS9kQkzvzBU3CYWtD9cwx5QsTLcLvErWnQ3EKbp/bTko6xHxoS0PiiRXHD0clNvk5hm+WD/jZsSeqzIoWxhUqwEDnvrUVcBZg215lqXVbx+OQ4lPwGX62m0XHr5+rR2YwOHdDcw/wCnfL9tFBXZnT7DBNlXOqVuz2c9DOpyO2w0UhAkFA+u69ph6L+vTKlU6g+O7gYBGdrZ5spA2PatU73K7VdfnvxJRWOv/nWgyjcJIzp5sTgLaI1sOi47QRcz0tpQxF75Eo/BrWghjjtlaFN0bec9j24NHAFf6/+kQs3u+E1E/YQQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8060799015|41001999006|12121999013|19110799012|5072599009|23021999003|24021099003|51005399006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?84q5CYhyarlxgE+G9/Q5T/nxxT7tVSXSrA4OxWsMSU+vc3Tzi1KkGZgylbxV?=
 =?us-ascii?Q?JpiWJlQrUCF5ywrluT+IvLDwZYP2HgerVGs6sWMCjv5i5yG+nL8DTStYVOz+?=
 =?us-ascii?Q?Z+uQBYUd/g8F3h7bois9Q0CLB+XLBc7+9ZahTidP32trCQQIILaXf2NhvmBp?=
 =?us-ascii?Q?BenS6YaV5nB+M2UQPCEt1FHVKo+FQCWRqL2eVCgWOrf9svxwreiR/Y0ueBt6?=
 =?us-ascii?Q?H29mZ+5HkEh1h8eINfCgo7WWVsulctebsDAn/mYRm+8h2U0BKMGjACp0/xps?=
 =?us-ascii?Q?vAoCqamyCZzK+7QKJifH9Lxd2NkwPKnBX8tbLd6PtHknSfKGW7zn0fu6Q3/l?=
 =?us-ascii?Q?FRk7yI3lG2AS8pegXCg4VCQtJglVtN6kSQmju6IM7muL10UP6yvp2KR3o8AQ?=
 =?us-ascii?Q?Gjk1TfkRY/b4O74zuj73TBAILHKev7mrmNCJ2/QjL0YhPiJiEY4DnBXC6tK7?=
 =?us-ascii?Q?QqOkLGspPupTqq2dyQTCS3okl26wK7/dInQgGnPwvOIYDi62cdtPhKsUpGiz?=
 =?us-ascii?Q?sAEPigi6dh1yWlHh2WaE7nY1kN6KOObk6e71qbXVfvzVUSqEzf3SEYRse1tx?=
 =?us-ascii?Q?smkrVV09qFBXYRvgDNcFBLvAvXEJXe6SsfJiplVH2TB6m26o95RxBsyrs4SB?=
 =?us-ascii?Q?GmMRli70ax5AU7mgfmIBUl4dqTp74V04hJZatOxIRBj4wy7iV8IxYiypkAHN?=
 =?us-ascii?Q?7fu32pXgRJghmW2658aHiCxywY8BU7lUHSzRzf0nKgS1+PfBOnt/gwjhuclh?=
 =?us-ascii?Q?twsVFz8Q8PWnpaEoVmdeKlj3UQl7r+mz8IMgNaxfSAgtE1qoEKK8DOGyppie?=
 =?us-ascii?Q?lqtjphVw4jjlnwW+FH3kwBz8hcBOlO9GuHUanOxZcqaLmIp6bhCqAKZ1iyxG?=
 =?us-ascii?Q?jvAahtW9Qgp+ZtuwIl7ODNJyx8z5AyYx8fbzuztV3GUatgk784mL6gSJvLSz?=
 =?us-ascii?Q?OhwErZ8CF+yoXXWX36exzJRJDYSHMYJitSmfskWoHOKzys6Hwhhthb1j0tL4?=
 =?us-ascii?Q?DMAz1/uz2VwaMMKkYdJjOE0rkAtvhCip91xBZhQD1yEn7c8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gc3gHn9b2AimSxG8hfs6sXDao8zTBIIXDcRumljzdxAot2m0hAk8+zQQY237?=
 =?us-ascii?Q?4yKDaRp/scwYTufwnxc6x6h60VwbUOPJA0UL7ehziv5DDJUbjqF/o59iySyI?=
 =?us-ascii?Q?AiRJT14v1dZLQZOKdY2KF5JDCs2tHSltcu0txWTRw4pfKsWAY+S3Z/kubw9E?=
 =?us-ascii?Q?zsHXXOvUIi3XBhTbaBA8F9x6wTS13zEAsvofjI+3D2mRzYt9LRAO/l9IHe+H?=
 =?us-ascii?Q?p/FmautUT7Jb269H/+WephI5EP8v1Vfbe5nKFH3Rj8VY4dw2sy2kgUbQgSoP?=
 =?us-ascii?Q?kUOwDFUdCyX+DM6/QZeIM6dAUU+m7yGLi7JzfqeLnvfnhR+K7Y0tvzvoqUuG?=
 =?us-ascii?Q?ph9PnmGpcVoLHzs3FganPBCrjsPKeyfW0Xnc3ih185HDWvH/oaJ9jSVlIJCh?=
 =?us-ascii?Q?bFjPNvmf9jaycUkEjHH9tlWkBYliyNZXVjfPdAmG8dQ24RQoVhHLLQ9o/S+H?=
 =?us-ascii?Q?u/7HxzV5QBOiSQglT5XJtGs2q0zdB/FK/nMQ8WrFnT2QtlTVjt+Ewyn3aYJX?=
 =?us-ascii?Q?gnrePRbt6VoTklMIXTbBkXMzEB0nwvWZxdIkH5bJCx5hGiA017Gq9KS8Ut/X?=
 =?us-ascii?Q?ewzOMadAi3k+T/u6nyyV35Gt2++uSeBkzBBCf7Acj+vFcyWajJ0lCijwOmmn?=
 =?us-ascii?Q?Sg+Aos7HNnhi8FCf68MNq5caTl50YFORG+HlBNgloZWlO6OjP2xxQSwDNOhM?=
 =?us-ascii?Q?gdYLjuTvAqoVr/cBusM7KMPwWoG+UTU6cW1oGQMdXOlxpRd2gCjChvI9UH2n?=
 =?us-ascii?Q?bXj8bja9V0jDlHvrD0D2D8qO9ev8gExpObs5zyVgg7dGnFfccNRZiinIc/iv?=
 =?us-ascii?Q?RxqW1wiHyxtv4tEkyPEUjzs8BuWdO8oVVyuBg9HVkDnfkZMlSgWox0TZ0c1Q?=
 =?us-ascii?Q?Suvfv4gOTGQtj34zQDm8uE4YeOAnnu8FowYn6ylJ/RoLqJ0JZ1zGqE5j69Dj?=
 =?us-ascii?Q?gPKJIAr3fj1M5lxKDncGWVv2J1q6wX/jFP3eKEVWNX0whsub5SIlV/MlYUQk?=
 =?us-ascii?Q?can6f9SC99fyULqq53mBTS0cP3sdLfj5HrQURw38LqXeTXD8O5KNDWecNMRG?=
 =?us-ascii?Q?Ql1OoOAIG0dsp1Xzs0hJPgKdfmCHw9RhJD7/9+Wrl/QCENAskRlwgzxfbNbW?=
 =?us-ascii?Q?iBmclq3oXptic91+pjIiJbsMn77BPLc76391lzYgDO0spO2duiR+oqXg2FdD?=
 =?us-ascii?Q?OchBvadu/mPbCiWF1aCJdj47krymnfD/r7Ieaz98/1lbrKn5vq6lMqv6DCdu?=
 =?us-ascii?Q?CTaGueFQwLHA3GiYJ4bBFIQI4FQniZhdaauoWdf2yUTDDhae1AVT/aR9pUfO?=
 =?us-ascii?Q?bahNTNp/TxeS2WCP8DOXkz2vXlq+Suo9ALLUvKZvS5FdjOJ9jUYETsNAopli?=
 =?us-ascii?Q?jbD1BxG7ZzSf/pTg18S8cDKekd2g?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7396374e-f2e8-4cd2-ad2f-08deb63248fc
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8559.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 05:40:22.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13379
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-7663-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,peak-system.fr,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jamesgao5@outlook.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: F39FE587D59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The channel control index ctrl_idx is derived from rx->len which comes
directly from a device USB payload. The mask 0x0f allows values 0-15,
but the array size of usb_if->dev[] is only 2. Values 2-15 cause heap
out-of-bounds read, eventually causing kernel panic in the IRQ context.

Add bounds checking for ctrl_idx before the array access in both
pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error().

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Signed-off-by: James Gao <jamesgao5@outlook.com>
---


Hi Vincent, thank you for the feedback. 
I have separated the declaration and expression.

Changes in v2 -> v3:
- Separate declaration and expression

Changes in v1-> v2:
- Use ARRAY_SIZE(usb_if->dev) instead of PCAN_USBPRO_CHANNEL_COUNT
- Use -EINVAL instead of -ENOMEM
- Add newline between variable declaration and bounds check
- Wrap commit message

 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4bfa8d0fbb32..ac22d7718299 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -534,12 +534,18 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 				      struct pcan_usb_pro_rxmsg *rx)
 {
 	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
-	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
-	struct net_device *netdev = dev->netdev;
+	struct peak_usb_device *dev;
+	struct net_device *netdev;
 	struct can_frame *can_frame;
 	struct sk_buff *skb;
 	struct skb_shared_hwtstamps *hwts;
 
+	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
+		return -EINVAL;
+
+	dev = usb_if->dev[ctrl_idx];
+	netdev = dev->netdev;
+
 	skb = alloc_can_skb(netdev, &can_frame);
 	if (!skb)
 		return -ENOMEM;
@@ -573,14 +579,20 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 {
 	const u16 raw_status = le16_to_cpu(er->status);
 	const unsigned int ctrl_idx = (er->channel >> 4) & 0x0f;
-	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
-	struct net_device *netdev = dev->netdev;
+	struct peak_usb_device *dev;
+	struct net_device *netdev;
 	struct can_frame *can_frame;
 	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
 	u8 err_mask = 0;
 	struct sk_buff *skb;
 	struct skb_shared_hwtstamps *hwts;
 
+	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
+		return -EINVAL;
+
+	dev = usb_if->dev[ctrl_idx];
+	netdev = dev->netdev;
+
 	/* nothing should be sent while in BUS_OFF state */
 	if (dev->can.state == CAN_STATE_BUS_OFF)
 		return 0;
-- 
2.53.0


