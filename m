Return-Path: <linux-can+bounces-7614-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PGDKQJKBGrNGgIAu9opvQ
	(envelope-from <linux-can+bounces-7614-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 11:53:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F74530F92
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94BEC3009037
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936E3E9C0A;
	Wed, 13 May 2026 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b3VYVdv+"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011013.outbound.protection.outlook.com [52.103.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E018787A;
	Wed, 13 May 2026 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665982; cv=fail; b=iP4Y3tw8eDybF4tztLN9Np8bKM49KcMjNdM6Qr8DWXWZBsdT9P+z8nuZdzN9vWo3i7bemZ5lMM/0OPKMFgo4G1gmoc8DsYHa3TYo2sHed4ADuTneR45GSxMhyRyEIFHSqIOhfVn9PvyTWNFV87UObEofH1XQEJTKb6BriQgis0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665982; c=relaxed/simple;
	bh=Pq+GCrFz0xVbuqtAPaydfCLVSZktlmZFuOxDgRgvFF4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dIZfFM+CuZ1WwXpU45LcQLSm3xMXc2DOFnEV0gg6TgxvK8R0ADaplacTO2uO5aM1TjkPPm5bM55WC8m8RgVbqK/sDk38ZWQ718CJePU2yCnsO8DgHDw1v0ztZ0OamLy9c966AgbDuY74e5ALnRPMY9/UgstGhpJsteHLsS9Xs+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b3VYVdv+; arc=fail smtp.client-ip=52.103.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6L54dFB6z2Pzr6SGo7+EsM5pqdhPYrqJ2qeAVqFXnz26U6S1LvntSlM1q255JEomCtXr+Dla1c87X2XshDCU9DZOHlOxWZfP7rWeERgrv8Uv4x1b7CGwGvEyy1eC52djxef75fVJUChLnLMgNN8/UuTrH6rNMFytfMe9JDkQ2Anw5Yk8YXiVJGHkn24JrEvCyFCSOsIqkMmDlv1LcTPE4fq8vrC1fWtHKRKHs97FQiP/RtSHGbRBQrqXCp9IOeXllxL/aeMOOz49xHT/58+etEhSYVAr7YSqLX8jvno8z02bFunzWPG0/8ILT71eJ0yy8cKP72c9xEGsXoLEHgupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAs9Se1YdTWT1rJlt6XIFoC9JPouQ7rtBi5+w+4pdNc=;
 b=HmS04rwMsazlSq2d7Yw0SC3+naFNinBIQgbD6md0kDJqyhfT9GQ3eW75xkI1KxVkGd6c9RREq10OCTLx6lprM25K5Fh55ThiBRK3lG3FwVyXFcAK4eahBiz9MXhjbjFnNMuKrHo5zGiPm6X6cnEAY7PUTnNkXr26mZXnzsYj+weKajI9eeHpmC0YspY+lXw8kBAGBsCAXuDuHgF8h8YhMXxiwCxhYX4TWYHpriQRgr9xKm4wK9kl/X948Qe8HovkQzX5D6EJU8pzqsehDDiCMPp1j431NsNs3f3IokZJE/+Bzjl2FVkjUVUtiPGiN0zLIoRspbzf4iBARaCJAPvQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAs9Se1YdTWT1rJlt6XIFoC9JPouQ7rtBi5+w+4pdNc=;
 b=b3VYVdv+FT8Ewjx9NMTmaDy86cVhMe0kY3861WCBNl1Z5XHAzGYorvgzBgm6Y2pU5vZuSpF+Vqs32gmp24yDDaM7VfJ9J4SfbEzBX75Po7Scr+nFm9byvPl5jyDG2OBgTLMdfmJhmrBCdxmfnxAHFvwecGoawuiuA4PbXZLUg7GOz92DdDrj+EaCNhjj6ieY3piMBX9zo0diJLJu5bqlhMe1liM7jyrqQmy9E0/I+r7hH9SmD1yS1FsFrqNfnIkmZBE9GrjGCDEsFZTXtxyuTmCvL55EUhcj9vbACX/Qpzu6Mv7Bd7BohUp7lkVFuU2E208adjbAdRRkKt0urK9Ibg==
Received: from TYCPR01MB8567.jpnprd01.prod.outlook.com (2603:1096:400:13a::13)
 by TYRPR01MB16146.jpnprd01.prod.outlook.com (2603:1096:405:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 09:52:56 +0000
Received: from TYCPR01MB8567.jpnprd01.prod.outlook.com
 ([fe80::c8c7:c2d6:bc0b:44bb]) by TYCPR01MB8567.jpnprd01.prod.outlook.com
 ([fe80::c8c7:c2d6:bc0b:44bb%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 09:52:56 +0000
From: James Gao <jamesgao5@outlook.com>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	s.grosjean@peak-system.fr,
	linux-kernel@vger.kernel.org,
	James Gao <jamesgao5@outlook.com>
Subject: [PATCH v2] can: peak_usb: Add bounds check for USB channel index
Date: Wed, 13 May 2026 17:51:53 +0800
Message-ID:
 <TYCPR01MB856782BAA657447E5EDDDC1FF0062@TYCPR01MB8567.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0037.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::16) To TYCPR01MB8567.jpnprd01.prod.outlook.com
 (2603:1096:400:13a::13)
X-Microsoft-Original-Message-ID: <20260513095153.2323-1-jamesgao5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8567:EE_|TYRPR01MB16146:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f004e98-4e24-41da-6771-08deb0d5684e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|23021999003|24021099003|15080799012|12121999013|19110799012|5072599009|8060799015|41001999006|52005399003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c3uUqZ0YnKUPyfj2QS/VHnEpW01WtVE2zajLjiwhugWT7IBEu6OISX2PVCJw?=
 =?us-ascii?Q?0C8kvafk7ATNYtQ9Tvx//+OfX5EMGkPQUJftkSWoChmrZ4ry8PDEFHy4GBi7?=
 =?us-ascii?Q?nkbCIkMjc2loWNz0tNVGD8KFmSiMHz70v6LWLaiwNcsYJmP4e5xxLbogfrzv?=
 =?us-ascii?Q?1R9ydK5ltf90ud5o9DtqitoBFpB603GXayxA3FPoop6Ug4coYtHDkrhDLHmn?=
 =?us-ascii?Q?KmttSmxNTUJlNKkhuKPp5Wz+nU0qCdwhtqa31+ayFW6dQ+MOHYZRA6flPjMs?=
 =?us-ascii?Q?KJKWx/AsOfWO6JBxeZASUcK9xxM09lpQaihm+1udTpnzZOuG/g3xARYVH2U6?=
 =?us-ascii?Q?x+CQnIxLp2YIieU+MBw3ULxmtQLfYYLFlhIeb/3fhwOP8BYOneVa49smSZJ+?=
 =?us-ascii?Q?9uDvJUMvluDigdA7tYnWVTXjEchzVm0Jj5RsG+0EYMWCvhpTzkqXBYtkPkvJ?=
 =?us-ascii?Q?R0/yAGQGJTK9qyoTbhNyoQhQVbYTWuA2f78Ed5Supp24zEkz1MlG4d/hpMrm?=
 =?us-ascii?Q?+m//P5aOLg0tNpWHoor7nhXuY8rlH0oIczAsRbWkW2My70U+vEZJrt4yfLJB?=
 =?us-ascii?Q?I3OaItNpggHUvbwR5zfhRVjOsJB1iEk7n6n7Pi0A4fFKwFtoOVV3g17a+9gt?=
 =?us-ascii?Q?ZUo5b8uuQWYqoBsBRuO/F6BwIJON500XJstQsVW20QZSd9GtuJ0emzI8Tlw9?=
 =?us-ascii?Q?PzIecCy7JKbJZfffkkJdf2AnKqpcj3IbQiQbU5dzdDd/GynMVG9y2fM2iajO?=
 =?us-ascii?Q?F+90xEd5unYfQZdvuByFTKWHs3p39IC2tNsvBWHyw+cXaLV2S6W6mnPfU3TC?=
 =?us-ascii?Q?J6AY/LfDGnjjjSP+RrjapQx5esNEvcocHp4BrS5sdVchMVFcJtSVOwcWyTLu?=
 =?us-ascii?Q?MXmgW1BgEOpznkIhQ070VS6b5eNzAG3vz+HG3vDZSKdsySWbTt1Gk7tciDSI?=
 =?us-ascii?Q?jkaHfaMNbz9+3KIOgGAeAWq50R7+Eg7M/7MkyHHfydJECr4soG/bt7YRq2OG?=
 =?us-ascii?Q?GVnKjqYuKDVFDGkPRPouheGYLtRuPC4KMkA9Msb81LdIwVdbXT5jZDpRUKil?=
 =?us-ascii?Q?EIz+Rpj6?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iy6wBgSoQWZvrQVyy9cuaFVKpY/RTX4wTldOe7K0EROwD0wyxeRWs+duxiLI?=
 =?us-ascii?Q?7sUzl+V+hmGVmAey2Ly/GOjA3IANcagMVm8xdHu91DEJglhIvn618HQ4bBM3?=
 =?us-ascii?Q?mG3c/x3a6Lk223Ii/UOuKUkMFb39F+SHosr4kgoiL64rqUl+PqD5PQK39sHa?=
 =?us-ascii?Q?mwO3+NevGYWsy5CCbtbvUdLuw2sL5PHlo0gQ7b9ebpBI3qRTvyoTXpeh4ov/?=
 =?us-ascii?Q?+VLyyOk00H6ppzRvEovvZuM4TPHKVwVWagk8T/6Yy/Lm7lOf+XAiJslASSeC?=
 =?us-ascii?Q?gH0XlD+cYiHQO+WFnzSxjrN6O08uuAMEMZArkEttccLDbfSRRR/jnIyzoArE?=
 =?us-ascii?Q?ZVp8Zx6TChweZgpeq0SuoCIsKlie+mCMVDQKPxjrHLyVfaqiGQ1VKu4Bb8b2?=
 =?us-ascii?Q?ZVIw9jsLwu09HrUxzgTcy7hgovKZa7GSW3JmYk3i0MLoagUJMbdA7ew9ViTU?=
 =?us-ascii?Q?7NMQStXsPCeLA36u3rNwPU4wMqlN0NYN00FWVUMZQz/OALrBTKmzcLHT8Drx?=
 =?us-ascii?Q?hndPjWRlHX8BayADKhQpBw9/a3/60dZ72zs3QYxPxhIFC8Uys7EsBAuE016B?=
 =?us-ascii?Q?OtEcURmt6x7fXHZThCFbpNHyj1grUCuPs4lXizOBYu3jq2qSJFcDIv7MdECo?=
 =?us-ascii?Q?r2ZZF7EvAYDbrn/AJvvbIHIV8Og3VhoOXg6cQgSfgLZ3dxzLq87gwpdoqlaI?=
 =?us-ascii?Q?ro0WPliFfUBxeNO52w6Ndxfn7LooiS1shT1HbkI7ygRzNpMSsh/3rpvAzzPt?=
 =?us-ascii?Q?G74CahZQUfSZdSaax0ujKJ3OPAI9GqKajWP7onugzotBaMqTh7GIAbDGNYly?=
 =?us-ascii?Q?KnH1GHhdy8Y7cMZrtlvMdofbbWrx3Ag6x4Bo8d033h9W9sA3n65K+zJVTpwd?=
 =?us-ascii?Q?QpVqDgI9VC83F6gzeVy1qg+yGn+cKse+6h5OUXjX5f6R592dM1Ikdf4WXypY?=
 =?us-ascii?Q?dSVy4wvCBjyto6QBC843ddZWXMkE99PXKjJLas1Q0pEmxk2uHLjc3bwWsLUM?=
 =?us-ascii?Q?bxRzVbNyr4Xv++iNT90JBwKxf3P7MMZJTAHVhqXEUuy9VHVK/iCLk+DxRmmY?=
 =?us-ascii?Q?35UyaB5uQ1NLqZmfB4pt679MCyd1XwhRxi46MwVTAJT01Wv8B79FpjypgoYM?=
 =?us-ascii?Q?sVuTkJ9Rhf0KaSyF86sVjQUpZMOiFIr6nfYdMNGKGhECw3TTv0j6JI55TMjv?=
 =?us-ascii?Q?2K2R2zZXcgwl5iSgQj/4jSJCfDfhOklVtUy/NBpubzZTGlgogetjGm6OOdxK?=
 =?us-ascii?Q?HxOJGk+hPUGOiRe0VMWgfwdehkXRISd7Gioi5pXx4UjPGSgO3D060yBVs0uV?=
 =?us-ascii?Q?dtY82R6wshaVcZ7u3SNNdNWrBqC/aQlQ5S8w1MLoLTIjsu3/lNBrgAoW3jkS?=
 =?us-ascii?Q?fuF82QbyRzaQNKbk8D4iUWiTelYISLvERqcKwRorO4OuV7iXEb5NMHDv7LLv?=
 =?us-ascii?Q?8vY+Wumi2stFIvt72lR6hGXv7waTFizL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f004e98-4e24-41da-6771-08deb0d5684e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8567.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:52:56.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16146
X-Rspamd-Queue-Id: 17F74530F92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-7614-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The channel control index ctrl_idx is derived from rx->len which comes
directly from a device USB payload. The mask 0x0f allows values 0-15,
but the array size of usb_if->dev[] is only 2. Values 2-15 cause heap
out-of-bounds read, eventually causing kernel panic in the IRQ context.

Add bounds checking for ctrl_idx before the array access in both
pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error().

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Signed-off-by: James Gao <jamesgao5@outlook.com>
---

Hi Marc,
	Thanks for the review for v1. Since this is not a security bug I have
	moved the discussion to public mail list. Changes in v2:
	- Use ARRAY_SIZE(usb_if->dev) instead of PCAN_USBPRO_CHANNEL_COUNT
	- Use -EINVAL instead of -ENOMEM
	- Add newline between variable declaration and bounds check
	- Wrap commit message

 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4bfa8d0fbb32..5b1e3501cfb8 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -534,6 +534,10 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 				      struct pcan_usb_pro_rxmsg *rx)
 {
 	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
+
+	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
+		return -EINVAL;
+
 	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
 	struct net_device *netdev = dev->netdev;
 	struct can_frame *can_frame;
@@ -573,6 +577,10 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 {
 	const u16 raw_status = le16_to_cpu(er->status);
 	const unsigned int ctrl_idx = (er->channel >> 4) & 0x0f;
+
+	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
+		return -EINVAL;
+
 	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
 	struct net_device *netdev = dev->netdev;
 	struct can_frame *can_frame;
-- 
2.53.0


