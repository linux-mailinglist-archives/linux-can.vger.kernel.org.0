Return-Path: <linux-can+bounces-7408-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHUGLd5I72lO/wAAu9opvQ
	(envelope-from <linux-can+bounces-7408-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 13:30:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF5471C0D
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3723E3078178
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074373B7B90;
	Mon, 27 Apr 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="qEv9ajpp";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="qEv9ajpp"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021091.outbound.protection.outlook.com [52.101.65.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179413B7B9D;
	Mon, 27 Apr 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.91
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289200; cv=fail; b=nQq3HL5gBuWIRhq8F2Bry7oWBRqWIr6TqyLZe4l/X2plyZbm4T7NMdih3VKoyK93rQjmtJ32m57TzSDU7xYU6rPc/t9yInL48PFXAxV4TOBE0KLRlQDH+gYvXsjh0hJi11Xbbk8z3ZG9PS5bZ07Fnr9jgc00uHBNxP5umJfpLTE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289200; c=relaxed/simple;
	bh=Tn8LKthHKGBYBja5UGcrYbWnC9z7JEIp2HNjLzqAIiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fo37+a79B11zWL7kt01kLJf6+2aVe6g9qSqunF7XSgUOf2OSHtlJAEJBHYGXtAENP1Qe5ZXhTsXp2XIiergC3oDbhHvNI5eySCfG4ajSM9OmWf2IsqnWAtGXiMM5qrugkVj27XK6qqfE/cFSO6JrfPnPEAaUg0ZV5LBSJvSl/Uo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=qEv9ajpp; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=qEv9ajpp; arc=fail smtp.client-ip=52.101.65.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rH4PQK/wdU5G7RXeYtbzeJVjy/RZMadtXApF/uhySN0w/kXNsgRTeJuBPC20oaBN9LTm46mAtQoiTjrhGLqFdIEQVaPsoommgIT0TJ/5V0pHiCuqAs833uomO6SElBd/Y53Y02X8/LGOghDh+fu0gdsXSYp5J2KUXoFDAWSpMgj/WMJ0QsVfzmL7ytlKY5mF73U1C1BgS0TMXQMBIwKxkgUyD6mzeeurHsy5E0Wm76FeYqqqFvHvkdzdGmm1AwPdfdbbrON1Eu2IsPAmtC4kfvjD90oHE91IxZRXF7i3GsT0r5rKZUNgKDss7HhGSMr6rCmq+UvMpX+WxvDfTRs8SQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn8LKthHKGBYBja5UGcrYbWnC9z7JEIp2HNjLzqAIiI=;
 b=ZPHvZEJOOEOmkb6fDfQ6qcArghzRi2evuCtBSSS+fShx2DO+FjLVGTls2VS/nYzw/kV90bsIkGNaRUwaJ7Mc72uPpUzlNnjqgKSpkSpj7BML0AsKLfZYwVLN2yRKM0IHDdCF9BnaqHynTu6+KDIvLHgCZFBLbCP6qsC2bTQwgq0iJ0mBVx+wnO1jpskjkTEpW4iYixd9sk7nG0zBjFfJiZtxraWbCwg0H3eYsoccYCaVcdPQkV+qLzcVsGcJ4FUjOzVAqkMsnvi2qKu5H1Qt65fKReP4USXh/oxBF1rGOX1kBHxfhEaB1WvaTVfUBwZXdNjqOxf6IeDaZPUp77/pSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn8LKthHKGBYBja5UGcrYbWnC9z7JEIp2HNjLzqAIiI=;
 b=qEv9ajppyfWetikKxqyqCH8mYutxuBDmtcpzyYH7ZAiM9X2nDn5LwJL1+F300QZJYbzacd5oeEPjFQziAXl216XvxxVRfzg6ioAr7hlsivXisERK9P826gtSGA9GvYZFRS5PVh2KFXg80SzqiRZ+fgWgXXSkdC8D21bfqrhAIi2XrlA5phNpf6tytSFrwF+KNz5xOc5Iytd0UTTa1s6isCt7+qFD9fLdHlYy0DVPPKMlUir9B4o1ahfNo/DVkMFfu/41Dow7dpPwuAvrGwdZGCAsGj5p3qwUO4O2BJdXK2+yCA3OB9TiTp4wpJVdCujdb/3nJt7GqHU0nA4mwVJJDw==
Received: from AS4P251CA0017.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::6)
 by AM9PR04MB8921.eurprd04.prod.outlook.com (2603:10a6:20b:408::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 11:26:34 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::fb) by AS4P251CA0017.outlook.office365.com
 (2603:10a6:20b:5d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 11:26:34 +0000
Received: from emails-2664216-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-243.eu-west-1.compute.internal [10.20.5.243])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id EB44580560;
	Mon, 27 Apr 2026 11:26:33 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Mon Apr 27 11:26:22 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASHPQGk3KFjQqWmx8LZKIhlQzQcbaJJYQmxsyySeodYINO4sxfOacjW5C3imZKMr86SnR1A25Pfk4o8FlaW67Vf+i5/qQuuxXfEuANCikWjqz5tbwtDAdJv1fNhKWGs95ao3wNo4Znh2mZtpklCB1TpTVhxmxShaFFN4NmUhvmDeDAYyuo+hnlG63grppZWuT53yvH/zJtGyZuXuBjpGpqtDf84e4ibKaXrEmm4wu+HFsdpLyJFsSn4pr54q38pif2/vMyQhqSbk6vlGhjxzLtUEC3rpIvRTa59/jdilox2CPWkVFDAOOKycAm+btve6yaz5hJQmmOJzssGbvjnorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn8LKthHKGBYBja5UGcrYbWnC9z7JEIp2HNjLzqAIiI=;
 b=alSd//B/46AnMBc+nneYGL1oFz0wBDKaMDUzKbx5L022Yx0ySmVdddvqEXS4c5TH2NiPI8DN1wC0lg6XNNhwCGMEfMp78LrKfWIFQIPZ8PY9wMTK+B0gUAFclX4xeCEvzEcH2Y61Lz2OR2QMKcQHOb0Opc3Y05+k0mv/KDanmO/0oPE5zLRshqfj6KuDwcfHJEWWaaXTB5aSJ4+VhN5uws7hilgSktKonoVj+5jz2QtGpCOAVlbSJqGyaKuNxKCb4JarAUfS8IoRvivbRWWsbyO+b/Ib3ed34qOA3e1wUc1BxkaLaLp2vvJtsE9nuFqczltkKXVJjXXNSa6wphChnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn8LKthHKGBYBja5UGcrYbWnC9z7JEIp2HNjLzqAIiI=;
 b=qEv9ajppyfWetikKxqyqCH8mYutxuBDmtcpzyYH7ZAiM9X2nDn5LwJL1+F300QZJYbzacd5oeEPjFQziAXl216XvxxVRfzg6ioAr7hlsivXisERK9P826gtSGA9GvYZFRS5PVh2KFXg80SzqiRZ+fgWgXXSkdC8D21bfqrhAIi2XrlA5phNpf6tytSFrwF+KNz5xOc5Iytd0UTTa1s6isCt7+qFD9fLdHlYy0DVPPKMlUir9B4o1ahfNo/DVkMFfu/41Dow7dpPwuAvrGwdZGCAsGj5p3qwUO4O2BJdXK2+yCA3OB9TiTp4wpJVdCujdb/3nJt7GqHU0nA4mwVJJDw==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by PAWPR04MB11621.eurprd04.prod.outlook.com
 (2603:10a6:102:50e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 11:26:20 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 11:26:20 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] phy: phy-can-transceiver: Convert to use device
 property API
Thread-Topic: [PATCH v2 1/4] phy: phy-can-transceiver: Convert to use device
 property API
Thread-Index: AQHctkztSeLY+p6L/k+DAzjhYpNju7XzBLyA
Date: Mon, 27 Apr 2026 11:26:20 +0000
Message-ID: <023d4800-5ec1-4c55-8c67-0c47f0b91e91@solid-run.com>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <20260317203001.2108568-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260317203001.2108568-2-andriy.shevchenko@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|PAWPR04MB11621:EE_|AM2PEPF0001C716:EE_|AM9PR04MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5148797c-e469-45d5-4d82-08dea44fd68f
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info-Original:
 0bAUl6XGayG7bk9yh//YUHFO6TQFBcj2Tx6rLcGWXCKmljp7KDB0HTSvOEhox2vn4qWO6Tdzj2NhJNS6KYn9U2MmVFSOu/HoofCUrrbdEplc4DjhFJbr8vW6NP+TOagZXaNaWzTmAgK3RB7CySK+cNSdjz/38RP/TVwgVgPnhFFM1drC/bsuu8V/U3/1TfA3ww/cUlbkt41fdcld5wy29xcWcMy2GkJcMQYP/KJWLPK3uoW5ZBjaVJKL+ZP4cEKKWiRF3YcoCMmDj4sPZ/0Es1xhKBK7pwMSDwmQYmy+IEdghdAecN6WW6ElWI1Q4B/MIO/Ln/ioMmCWv/jv/k1j14ZAvHjYTeXCSLaEYHVXlU3GuFBIH2eD8+6LmnBlIOfsbPMBGViagYONyZVUYofBmSQ3OlTr3iU+DfFARkIhObFhf2yG0RwLeJxBA3+0M7lr6Myv9GlTlRSLCqzo9wNrNSXyXFtynwYYbl+0LIg0T+7G17XWqgQVkE4U7j6WfSuSCbCHMQlFejB9mAAi/n0J5qhoC+oRoxRpNQLcKBGg8llYeWKlx6XRVKASKwntx9rs7E2uYQacWAnkCd2frhlUnkCr4CVWiwt6FqKnD6bazEIHnnu8YGGeASJd3YccJpjBOChgRSkSp+3zw9cUvZssfJmmhhTzhKRRdrBqbRVaZrVvJsn/Vi9DHmtOMris3rAWi9+dFD10LH94C+w8jsWxyx8PjKA51QGgsEXJGp3fcQaYjiJ0m0hGYiGMwhzrr/pt
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(18096099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E945FE39C99CC45993B2E7D851A1F7D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 RYB4+fB9bhI5p62PpoHUi+heOdbm0Oq84L9bt3RO5InP9lC/M/Hldfx1NvTxGh64G+jP+Y+J1l9keQ6wGq1AETJ4KvJ4x1qG4Qin4o9x0w9KCbuLszM2fJrofXpWPoaCl6GDvb2LnCdR7BcvTZKh9istxz/2VLCcCOdqMXNuSIQDhD5yEd9jjmuK6Gi3tkbApPa1gDuIsszcj03+LS8KXUTdqKW2foIOI55ScCIQBSKCrR3n/GrfY5kjl4KWCat2w8ucZCL/NXWDpikolpgyAtrUm4UgHm/Jb1NUl0DR+6sV1bgs9KdV0/CmRXfBkCXgnIhuxKIO9KudGpxltrQKMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11621
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 94ee501822f84d558ed716824be2b8fb:solidrun,office365_emails,sent,inline:e5f4c0cce52b3aa936fab29a235a2a66
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eb1e2851-46a7-470c-6a28-08dea44fce3d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|36860700016|376014|1800799024|82310400026|18096099003|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	3Ae4CNF8J/TPGnyLNiLw8uIXki7KCLK65wm19FpwZLTArh4xPKLupNe288cfb0fKUM3jEZl/rnbLEVFJ/AlnTubsq7eMZfjNkWtD9ALaVXiWPPnI9mKpN9rHTLn4+gC+C9lQGEPuDEti7YN1r+ax3/TFiqwXzgpFqiNKx5oejDhyyaF1bRZ6zq5n/Bt3WJwD1ol7vsrnRx1PmzxOfXM2fGNXsd/SBJevtuvoQfboxgtBOR/Yuud6aqfrI/r2ipig5e0FCg+rO7nQxW6bygrcP6X81W8sZ8WHEhC6vhXiVK6kGeAhgL1KoqYuAJbMBi8M6oIpqIELwV31o/1u/ZAU3vBjYc4JCEfkg2i5EJdeCCzlnrLMIEv+XSHnmfvQR5anOX3JmNgpfAitYWHrAMKxvHaxm6OsQ5jBTnv248fieWoGGpvxk4WkE4Wi2uuK6fFC7fxHvvLrbkskt0l8pxY1efs9f1bxbbQ2GmLjLfUy37lGlk6usR42VeyfQFOQQa2sAYmByTWYPFchNdb4wwyMWO2LKB35sQmoXDdhZ3LwST9aGGIrBi/RDhckciQWgS9jvtY5/mc5E8ZndodqLoA/rZE4ZbCwGjSqMbHyTMd23099Ag1m78q6G1/6wLAlj9RUnQBkeQLm/8w7NdarXIXbF8U/XWhlkuvNw6lIcxarQMWpyHPS1Z+IZfbD24wPGGmxFqIt0adv04yiOGx9/1dOgaZeP8/ppyN5lHEY3iYkN7o=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(36860700016)(376014)(1800799024)(82310400026)(18096099003)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XZc2G0EVpPsNXb93IwxzeENBMCxO0yPlSuU2q417d27XSJDE6a9AdPiQPXZJixwLlmDEdXlKtLDzPZW/gsEvCzkOSnpmw/Ry7uhMEYPlrtRpHZqA7lhOBRHwJYPFa8M2FSRTe91upvT5ZRgT1hUImhYX4gh23CanXqwYWShtsbDklT9lZbR2ecTgWx82/Pe0sQHVl2YCbCIx8NNIsZ499fC4hSFTNhyf0e+FZuE0rBpPeU86c2ir+jRrzwFikIFq1TJiK6Ks3EdSZzmnOvlJR7luhyMszpFdrtGluYGQ+cjJHt6fdz273eFNiR0qefqz6AhyLf1VuqSv36/7UOhmGoBEA11DLlKskVoam3W9Pno8GdzLHdnu5qtmWBLkdvZY3JFbY7SWBUPerP1+jHuBqNzafhdqWfOPf7HciXz2RoWvaZqYbHp13l+zKXaj/0gZ
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:26:34.1563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5148797c-e469-45d5-4d82-08dea44fd68f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8921
X-Rspamd-Queue-Id: 11BF5471C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7408-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,solid-run.com:dkim,solid-run.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,ti.com:url];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[9]

SGkgQW5keSwNCg0KQW0gMTcuMDMuMjYgdW0gMjE6Mjcgc2NocmllYiBBbmR5IFNoZXZjaGVua286
DQo+IEl0IHNlZW1zIHRoZSBkcml2ZXIgaXMgaGFsZi1tb3ZlZCB0byB1c2UgZGV2aWNlIHByb3Bl
cnR5IEFQSXMuDQo+IEZpbmlzaCB0aGF0IGJ5IGNvbnZlcnRpbmcgZXZlcnl0aGluZyB0byB1c2Ug
dGhhdC4NCkFzIHBlciB2Ny4xLXJjMSBpdCBzZWVtcyB5b3UgcmVhbGx5IGp1c3QgZHJvcCB0aGUg
bGFzdCBvZl8qIGZ1bmN0aW9uIGNhbGwsDQp3aGlsZSB5b3UncmUgbm8gYWRkaW5nIGFueSBuZXcg
ZGV2aWNlIHByb3BlcnR5IGNhbGwuDQo+DQo+IFdoaWxlIGF0IGl0LCBkcm9wIHVubmVlZGVkIGFy
Z3VtZW50IHRvIGRldm1fcGh5X2NyZWF0ZSgpIHdoaWNoDQo+IGV4dHJhY3RzIGRldmljZSBub2Rl
IGZyb20gdGhlIGdpdmVuIGRldmljZSBieSBkZWZhdWx0Lg0KVGhpcyB3YXMgY291bnRlci1pbnR1
aXRpdmUgdG8gbWUgYXQgZmlyc3QsDQpidXQgSSBjb25maXJtZWQgaXQgYnkgcmVhZGluZyBpbiBw
aHktY29yZS5jLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5z
aGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BoeS9waHktY2Fu
LXRyYW5zY2VpdmVyLmMgfCA4ICsrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvcGh5
LWNhbi10cmFuc2NlaXZlci5jIGIvZHJpdmVycy9waHkvcGh5LWNhbi10cmFuc2NlaXZlci5jDQo+
IGluZGV4IDJiNTJlNDdmMjQ3YS4uODBlZWNlNzRmNzdkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3BoeS9waHktY2FuLXRyYW5zY2VpdmVyLmMNCj4gKysrIGIvZHJpdmVycy9waHkvcGh5LWNhbi10
cmFuc2NlaXZlci5jDQo+IEBAIC01LDkgKzUsOSBAQA0KPiAgICogQ29weXJpZ2h0IChDKSAyMDIx
IFRleGFzIEluc3RydW1lbnRzIEluY29ycG9yYXRlZCAtIGh0dHBzOi8vd3d3LnRpLmNvbQ0KPiAg
ICoNCj4gICAqLw0KPiAtI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
cGh5L3BoeS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvZ3Bpby5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3Vt
ZXIuaD4NCj4gQEAgLTE1Miw3ICsxNTIsNiBAQCBzdGF0aWMgaW50IGNhbl90cmFuc2NlaXZlcl9w
aHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzdHJ1Y3QgY2FuX3Ry
YW5zY2VpdmVyX3BoeSAqY2FuX3RyYW5zY2VpdmVyX3BoeTsNCj4gIAlzdHJ1Y3QgY2FuX3RyYW5z
Y2VpdmVyX3ByaXYgKnByaXY7DQo+ICAJY29uc3Qgc3RydWN0IGNhbl90cmFuc2NlaXZlcl9kYXRh
ICpkcnZkYXRhOw0KPiAtCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0KPiAgCXN0
cnVjdCBwaHkgKnBoeTsNCj4gIAlzdHJ1Y3QgZ3Bpb19kZXNjICpzaWxlbnRfZ3BpbzsNCj4gIAlz
dHJ1Y3QgZ3Bpb19kZXNjICpzdGFuZGJ5X2dwaW87DQo+IEBAIC0xNjEsOCArMTYwLDcgQEAgc3Rh
dGljIGludCBjYW5fdHJhbnNjZWl2ZXJfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAJdTMyIG1heF9iaXRyYXRlID0gMDsNCj4gIAlpbnQgZXJyLCBpLCBudW1fY2gg
PSAxOw0KPiAgDQo+IC0JbWF0Y2ggPSBvZl9tYXRjaF9ub2RlKGNhbl90cmFuc2NlaXZlcl9waHlf
aWRzLCBwZGV2LT5kZXYub2Zfbm9kZSk7DQo+IC0JZHJ2ZGF0YSA9IG1hdGNoLT5kYXRhOw0KPiAr
CWRydmRhdGEgPSBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gIAlpZiAoZHJ2ZGF0YS0+
ZmxhZ3MgJiBDQU5fVFJBTlNDRUlWRVJfRFVBTF9DSCkNCj4gIAkJbnVtX2NoID0gMjsNCj4gIA0K
PiBAQCAtMTg3LDcgKzE4NSw3IEBAIHN0YXRpYyBpbnQgY2FuX3RyYW5zY2VpdmVyX3BoeV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQljYW5fdHJhbnNjZWl2ZXJfcGh5
ID0gJnByaXYtPmNhbl90cmFuc2NlaXZlcl9waHlbaV07DQo+ICAJCWNhbl90cmFuc2NlaXZlcl9w
aHktPnByaXYgPSBwcml2Ow0KPiAgDQo+IC0JCXBoeSA9IGRldm1fcGh5X2NyZWF0ZShkZXYsIGRl
di0+b2Zfbm9kZSwgJmNhbl90cmFuc2NlaXZlcl9waHlfb3BzKTsNCj4gKwkJcGh5ID0gZGV2bV9w
aHlfY3JlYXRlKGRldiwgTlVMTCwgJmNhbl90cmFuc2NlaXZlcl9waHlfb3BzKTsNCj4gIAkJaWYg
KElTX0VSUihwaHkpKSB7DQo+ICAJCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBjcmVhdGUgY2Fu
IHRyYW5zY2VpdmVyIHBoeVxuIik7DQo+ICAJCQlyZXR1cm4gUFRSX0VSUihwaHkpOw0KDQpDb21t
aXQgbWVzc2FnZSBzZWVtcyBzdWItb3B0aW1hbCwgYnV0IGNvZGUgY2hhbmdlIGxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCg==

