Return-Path: <linux-can+bounces-6344-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFkiBDIiemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6344-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:50:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C12EBA32E8
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78170308626F
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988D363C5E;
	Wed, 28 Jan 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Oq81wvNp";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Oq81wvNp"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021079.outbound.protection.outlook.com [40.107.130.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66C3612C8;
	Wed, 28 Jan 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.79
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611602; cv=fail; b=FJ9Q+o1zsB/waqyF++GhFFp9lYV2QmJvfeNA515K9JE79wSuXM/IURz2PCoixVO3d4vUgesk9ZEYzxCBdju7M2w0hFk14e8dXcGBIkvDrymun5rKLdFpRGuGjcr/rI/bqE47eVUb/+EF3S0buR7xQvdAyrLtSsEArs3qKKbEOaY=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611602; c=relaxed/simple;
	bh=FwCeAlL65jRAmNiqr66Ng9q+KFcUiAA1V+QFDlOA0sE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cw7FQQZ2AhWJWvvAn5gdvlO75HK+F29UFveFFV1kUSSCtHP93JDTT2IDgmbS+MaaqPL5qaAmcbSZ+TEnsMr+L9+IMGkneyQr+7m8SrBfw9Px9uyu4mpfZy3BV4EmDNUCVARoEFoKQuZR1mq1TO7tchvXIdzipN/odE2ggB1aDDo=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Oq81wvNp; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Oq81wvNp; arc=fail smtp.client-ip=40.107.130.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=U3nCBZ7z3qTSNWIFcVOH1ik0XenIVYwj+LMY4wXPDruvzYE7xznv5yEysQHSrE+9MVHvsdj6IuqOiHwTYKjRspeRX1nyZzD2Vcq5E+8Q1XiQJXSSsiyo6gLMhzNMJiVoq+mLsZLuK2iq02pb4GUIax2xg22SFBAQjUIouN2X1A1MIquxjV7E+KZ4PPNtyjmZhatERcHBZ3Oq90LXT4xk12y1aeHZUwSXuTtJqaqjUagANhpw4QCebwUQhV825p37JcWf/rGaQl1pM8Q+Ej1QJHtcvF/9dzx4/w1nXkOn5drAZT7lzQxIqWevJdz4ROKwVWRb3Ghnk5B3U1NkaTPipg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=p0HiPze87APRQwzrrli3wnBF07bs7rr+CIxcovNozKwxKmu+ehCXfpS7YMshd3EX+xpbEnrP2YkH+ipIVeX/FzLemPHFcFeRWPTLxjo4UHSDJH10UK/f1st+UpFQieSOuuk19T9n+PoBFTF8J1TRfZTOwDRs336AmEraizcq6vAPZunUvJovdxYT8ZUyYI4iHNaQRxR3/FU1wDmlhDhzXDZ1GW9Qji4MF9ndOfV1qsdFpDQDwqNq8hGzHS6YdvtNiho2cyEqa1Nkx1mD2P7LVBBruOCKCj+Y8T5NNNeJt9guRooZ1KCn/qIsK4QXbhV60+2vgltBlGMJ0uPckji5CA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=Oq81wvNp4itma/AoZIDqclXCBetxFdWIsyp3IeQNi9POGY596v3rLKG+KW5iuNdUnBsO6WODgnx6YgLpDk9QQ3sIBjP1m8LpclP0wyiPbhpDtT7hIDq4bh3iKWx/RQWqExfTtVcFjW2oID/rCcr/YOOBXIJFmCijdEzjMrNNzh0=
Received: from AM9P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::28)
 by DB9PR04MB11626.eurprd04.prod.outlook.com (2603:10a6:10:605::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:46:37 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::c2) by AM9P193CA0023.outlook.office365.com
 (2603:10a6:20b:21e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:46:36 +0000
Received: from emails-2719584-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-51.eu-west-1.compute.internal [10.20.6.51])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E525E806AF;
	Wed, 28 Jan 2026 14:46:35 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1769611595; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=nDNpfg6HBTItZu7RR34qwdvGfoZszkgAIlBhSMSmGIoQLCBq1AkQh8ZM/v0CXHG08w1lF
 /8yGmH+c+K+0GY/JsHB3FuUK0+1qwUmcayLJiwPlcIu9HUSGAIJGoF0mObzIKeNh1B77kT8
 MgasPupCmZjx7KTEJSqI6nmEhsY4Rvk=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1769611595;
 b=XMAfqaeMaICS+2ZPy9JAuBKY0pjVqgkIPYS/l/EqXZFc0hCYI4b2EWCgfyRgJ6+0CUGfH
 1bz/x9FYbrW8T/GsRviwSAjmMmHCVVQBGHC/9/JxUyoC8VD3pQQ+qPEZoNI3U+2AMJR8Ddg
 pj+H+6q98LcOIarCWG1uiJZttDFnzzM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9cw5rmd/AtHUdaImYELzi2DY27108J7c1i2+rXOt87hOTz1q0jqizghby390W4Bk/UCMHZpz8hZ+W0CKl5Yolif5PSXD2uzI0Qp/MrehKk/LNZzOgzEID1bVHkirUflKYJqJ6Ht7p3Tt/c5YcxUgoUpsuHvgEeCLcKbEQE2BEwMxcU66OiR/8iqdCfj6TTnK+pKwwHNMXENvrCuP9cM6icwn37KSGZuTEo5OshUPIUL7F3e7q2WcRiU193Fu7rlGKiYdhPkNFRlIVYbLSMzlPGQWIqjjS0ePHy4fEBVStXD2My77Vs+GH9bLjstDHJEV0V+oiFqzFKzt5k2rIyTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=TEcE5qfzTR92JA78q9prAtIuBMgs41bnBHHz75/OreB87Sli3F09N/HYaqQLHgJWwVt2hNeu6ygs+Q2I24Pvnw0QQFGq38tB4ytEJHC8UTqIKpQh0E44ICyWjr6GWVLlTAUIvlZVdjkfImgvMET7C0pHBBIAs1sGt85oZgTtUNfWbij6/B8BB4KQCXp9desZn7lc4qc3zjIlWReCsjsZkO1S9ionOEmUtblgSWSZMuBjLDdgpS92RHTEJLdHkCIvWcfe2+Bu8e5WTTUzb7Fc/ifCCG/FrmdUpSsBMeoWvjy/BW4l9jOObR89ciBo2tlY/VVKeFK7KmN9CBIN0fjYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pizegY+vhZ9WSMU6yMlOBYaIALnD5aWITlqWYzAmX1w=;
 b=Oq81wvNp4itma/AoZIDqclXCBetxFdWIsyp3IeQNi9POGY596v3rLKG+KW5iuNdUnBsO6WODgnx6YgLpDk9QQ3sIBjP1m8LpclP0wyiPbhpDtT7hIDq4bh3iKWx/RQWqExfTtVcFjW2oID/rCcr/YOOBXIJFmCijdEzjMrNNzh0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:46:28 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:46:28 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 28 Jan 2026 16:46:13 +0200
Subject: [PATCH v7 5/7] i2c: omap: switch to new generic helper for getting
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-rz-sdio-mux-v7-5-92ebb6da0df8@solid-run.com>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
In-Reply-To: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PR3PR04MB7289:EE_|AM3PEPF00009BA0:EE_|DB9PR04MB11626:EE_
X-MS-Office365-Filtering-Correlation-Id: e567b709-b20d-496b-8c53-08de5e7c098f
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aENQYXNmZjY5a1llYjgrKzZBSzV0RU9MQ3QvMW5FaHJkZi9wS0JRMFA1V2k0?=
 =?utf-8?B?VnFKWVk1ajk0bVJlYUovWHRzUkV1ZktTNHFXUVlRK3hZWE16cG80VWpMczI0?=
 =?utf-8?B?Mk91aFZRK21GcDRKcTVWc3Z2cU1YMWMrWTBDNENvNXBicm1CSXhFeUgvWTVD?=
 =?utf-8?B?R1Zwa1VidUgzenpWNldOa1ZzSWJRMzBXdEdOcmF3ejlTVHV1bndwbGxnenF2?=
 =?utf-8?B?Y2xpYmE5bVQ2emk2emtrdGZoMDVXMWM0OUNKZFIxYVZGZGdRYlJicVEyNDZR?=
 =?utf-8?B?T0JQSVdEOVRtb0loRmQzTWNlM01LUWlzZ1NrSXhBRndCQURkSFpmNmsvWjlk?=
 =?utf-8?B?aDgrNjV6cFY2eGJlV0ZzRXh1dFAza2t0UlBpUTVUM1B2eGlUSEsrZi95TFZT?=
 =?utf-8?B?QkVGMDFpVUpkZld2L3JRU3NxaG5VNExRRjFjbUVkMUhaUlk4cnd0czYvVkxL?=
 =?utf-8?B?UDBjc0NDVS85QldGNDZxVlJNSS8xM3B0MlVDRlhYQ1Z3SnZ0dHliWE56UGts?=
 =?utf-8?B?NTQ4R21xbmZ3aDBmcXZ4ZU9CbVV2YnNzenRzNjUvNzN5b2ZLWlFnOWozdWQv?=
 =?utf-8?B?SG9SQnRSSkpZazIvd280enpLUHB4YXhjZjh4V3E3cEtFWEMzRnp3ZjNlajNT?=
 =?utf-8?B?MlZaMWE5UWlFcjJXUFN2OWJRZ1BJTTFjd1FNUXdVZ1FQQUsrRllWTnEyU2Ur?=
 =?utf-8?B?UndWUzlGRy9HQmxFWmFxS0NFbkVJdmVEK3NkQmhDRm9VYWprQkV1RGgvZWU0?=
 =?utf-8?B?UEhSbGFhVWRoRXJYaGZXWndMenlCcFBpb1RoWXFZZzJsU01zcWtLL1pNNENr?=
 =?utf-8?B?cm5PODVNK0J5bjN4SUVJM0J6NkxiK3V0cXZzUnNnU1Q1S1NaS2JnWjRvQWp0?=
 =?utf-8?B?VmZBWWU4ckJiV3VSSlhQek1STG84QVIxbnF5TVFnZzVGR1l0MG80WldZMlBT?=
 =?utf-8?B?M0ZNWjBkREx2WHlqaXZuMXVKcGdJNUVGSEEyMjNtL2FoaWh2OGgrcUgwdTEw?=
 =?utf-8?B?M3ZMNHZtWHNxcDBvWFVyMkFUK0tvSFRjQW16c3R1OTRVVmVYQzdJclJjYTZZ?=
 =?utf-8?B?WjZQa0FabmRGbm9HQlgzVHN4cXR2N2ZYcUNzMmMvS2kxYUlURTVZd2d1enNv?=
 =?utf-8?B?bjRvTmdZbE5sZHd5clVIQWJRQXJnWjVSWXVvUjY2c000eXAzYVRHOHdSTXdG?=
 =?utf-8?B?R21yWStBWDNVTTlmMVh0TStldUdiZkhoa2VuRThTMnppZ1ZXM25QQW1rZUpF?=
 =?utf-8?B?OGRHOGVIUDVRSmNkWTVUaFJ3NFJqdW5FQVR5TWVmUXN6bndyckFHQlBlOURa?=
 =?utf-8?B?V3dzZGdwNUFZenB0MFQ5aVN6U0FOU1cxZU5UOTdDc0FYWGJZWnFGZHBOMERv?=
 =?utf-8?B?SVEyTERZYmFzZElTKzRpdWRFdWQrWUFJR0kwRDVXejkvQVkrODNVKzBQelZ0?=
 =?utf-8?B?RUhpb3JVVHdqd2JxYStYOWxoRHhCVlBNMUQwdXd4U0IyWWI5NURpVXp3TVdU?=
 =?utf-8?B?YzBhY2h0Y2dUZDYrVHM0OUlxRFBvb3FlTmhhOFhON2VzQTJVb3p1cjNhbFRk?=
 =?utf-8?B?TjJPZ2ZEdG42TzFKL0dqYUx0eTlvTzJIbHQxL1pvTW5QaUNodjFtQ1lvQ0Nx?=
 =?utf-8?B?cG1vbHl5TVhtemJTaXIwSnMvai92QncrZWU1UzNMcGhoVWIyUkE5YWM2UVNC?=
 =?utf-8?B?clRNMkNZMmhWUVJSeHFpZ1BENFoxOEdYa0lwbFo3Z2VDb1g4blpNbkI0SkVV?=
 =?utf-8?B?ZnZ2dFBLR05CeWQwUmFBTVFWZCs4NUROcWJiTVhrazZObEVqS1lkSnkvZm5v?=
 =?utf-8?B?VlByY3pIT3QzV2VyaUpsMHpMKyszWEsyY3hvTlBkaHpFSEdNUE4wMi9uMXpS?=
 =?utf-8?B?MExxMVZDQ0hOQTdEellyYjI5dUE3TUxGdHdUb1kvbnVDUTkxaWFBM0hFanRr?=
 =?utf-8?B?cnlWVG1XV0YwaFdXNXRBRTUvYWVDSEFjV1QvUjljalR3ajRKV2dCR3RIUW9V?=
 =?utf-8?B?WGg4dlNjcm1QYzYvTUpPME5vUWViK1NMcWVnQzB1REFrNEw5bWJUNnFGREI0?=
 =?utf-8?B?STNxQ0J5V0s3ZEFQQWlieFFQSFRsN2UvR3Q1MUwxa0VqS0xLSmozYnBUdFhF?=
 =?utf-8?B?b3JKUXhxZ0habDIyU2pIWndLNDdUTkJGTXd4Q3dQWnZxU2xPNDM4a3J0a2tm?=
 =?utf-8?Q?1zOhD0fkDCLcQms/opbiyx8eTO+vkF46PIEJX7tJJze5?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 3adbeeb26c8742d4bfb99c3dfc56c652:solidrun,office365_emails,sent,inline:5c927907a0056d3547fa923b049e9e5f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f520869f-32c7-4f34-62e2-08de5e7c04d7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|35042699022|14060799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG9zUEVsS0F6L045WFdaei8vaENOTXhDMGRhUEc3ajZFS1VQUFhaMXY1M1BQ?=
 =?utf-8?B?bGNGZmdEZ1ZvVXEzK2lOKzZBZW83TDNPMXFBYjRqWi8wNHlVUkRNbkc1MXlE?=
 =?utf-8?B?QkY1cytJaCtDMFpWc3Y2bU9HRWV1VDZBN0xab1ZsNUFIa2pMRUFnQU1ScGhK?=
 =?utf-8?B?Mzc0TnNmZ1BmWnFNSDl2Q3pMNGVOc3QraTN3dE1LYllFeGUvYWNDOW1OM1ZF?=
 =?utf-8?B?RlVRblhkNExQQVBhWDR1MkE3MGc1TjhoZkVJYlNrUUhYZVFTOGdXN1k1eUQv?=
 =?utf-8?B?SG8zd1gyK2tkK1BKcnRRL3IyTFArSm90SFY4VE1yMWk3V2d5Z25VQm5GMmRZ?=
 =?utf-8?B?aWhjVmlDT29KTDBISk9NTjk3aTZXdWM1N2lVUkNGRURiV1B4VmFLSTJZWDJZ?=
 =?utf-8?B?cnZPYWtuclZGdXdjcDhTbEtGMXUxL1J6eGdnRkhyeHFYZ2FZUjMzc2hoY3hO?=
 =?utf-8?B?djNyTnhOcGZKVmhJTEFRK25yN0ZjNDZ0WVo4RG9ONXpFQ0V0TFdZNENtSHdv?=
 =?utf-8?B?d0VDZS9TRnVwYkVoQ0dIRXh6eGxudzNCN1RiT0thenQ5R0pjR0VBOExHOWxQ?=
 =?utf-8?B?c2d4OTZkdGlWRWcrRjJzNE8wdWZLWXJuK3hhVlo2YnIwNzh6YllFUWFmK081?=
 =?utf-8?B?UlN2Tk0zRnpKQitoTGV2dG5EMm9SUTF1blZjTVFraUVadVdwOHFuVm10SWxj?=
 =?utf-8?B?QytnelF0RFVKN2VaNkxiMzBWWDNFb1lqWXdvc2NIZGdUaHRsbFBJUzllQlB4?=
 =?utf-8?B?aEw2UHVqT3d0Y1VjeWNIZWtnNmJ2SmNvbVpENG5HTEpBcm9RS01Bbk5oWVZ2?=
 =?utf-8?B?TS9KNisvaDlpN1Z5djRRSVBRcGtYYnFhcTM4eEVnWVE2ZVBMRHBxSnlsS000?=
 =?utf-8?B?RTQzS2JWTlZtSDFaYXlpSWlxZy9lOGR1ajl2VkIvNnhsVkFwd1FXQnJBRFdl?=
 =?utf-8?B?SzR6UUNsU292dkFGUHQyMzlrd1F2L0krQXFQVkJXeDMxQXN2aTF5ODNrZDNN?=
 =?utf-8?B?a1Mrck5EeVlOak53NjFmbkdRSm1uRTY0THh5UURKV3YyaFphb3pSdkdsQmVu?=
 =?utf-8?B?d1ZxYVVQR1QrVml5SlFqQzg3dW1hb3dFWGhnb0FabGZWTGRTVmV5dGEvdk5i?=
 =?utf-8?B?WmEyMFVUeDNTSDd1bHBTMTZKSjBlV0Z5VThKVWVHbkJZa2dlSk9PUk5FTUJB?=
 =?utf-8?B?aUd5MzJ2S0dGcHBiUm5kVzRJM1pHTnl1cnUyTFlmUUJ3Sk9JYTBKSTBLNThj?=
 =?utf-8?B?Z0MyWDZYcmZlcW1GNE9hRXkwQ3dIeUFra1g0Y1BET1FGNVdPcDRhSGUrWW4z?=
 =?utf-8?B?ekZDMml1dEhZUVM2NTJqa1IyWWQ0TktNZlR6NXB0V1E0MFdFZDcyVDh0ZWtZ?=
 =?utf-8?B?OHZweTY3Sy8vRE50ekN0WndySTN6enRLOTJQc1NZUGFLcUJ6d0t2OHJEcHFC?=
 =?utf-8?B?d1Noam5saXZwOUJOandMSFcrb1RIZ1M5ZWpiK2RpTUpEWldQSjJaYkVLSlJO?=
 =?utf-8?B?VHVGVGRhSGJwa1l1YVAwQkZsejZCREdaNDFHeXMwYXgvTE56VVhRM2tZNXYv?=
 =?utf-8?B?YVMycVZJVUZOWGpxdkczRUdCZHNMSlBVRlY3c2NUMFBsbk00RkUvS3ZsYW9o?=
 =?utf-8?B?RlM5WGpwSDU3ZjV6Sm5KY2dWaldyVGVNTkpjRkRCUGdvdzB2SkozMTFIR1JS?=
 =?utf-8?B?d1dadG1TZmsrV1hJcEkvcWtBeUxNWC9FZkpRTEw5TzEwT3lyUk9KM3pqVHJ2?=
 =?utf-8?B?TVA3aHM5cC91UUNYOWR1SVhlQWFuNGRaK3RkODlSbFFkcGZmMk9oeEhRNkgr?=
 =?utf-8?B?TUdWR3RVZ2ppMDJDZ0tPNW1pOUFKdDN2OFJXbGdSMENJTGptYnhZdXB0S3JC?=
 =?utf-8?B?eHpBQW1uSUxWMUttRisvTFJMK3A5SEZyVG9jakFYSHdpazc4aVYxRGtXRUZ1?=
 =?utf-8?B?SU9ROVpENXgybE5Td3gzTTRNRCs4VXRRaUpaNFhhMU1XdG10bTdjTU5CdUJn?=
 =?utf-8?B?QlZ0MnZFNnBIQTFEYURabWEvMDVzOWtland1QmhmNG5KUEgwQ1FVb3BNcno5?=
 =?utf-8?B?UnlDSGtMUkhocm5YbWN3bTF4WWhPbXpIM0Zyczlac2R1QmVUUlBGcHZwS3Vr?=
 =?utf-8?B?T0YxN2x6bURHbExOYytyZ3lWTXd3L0xNTE5wM0FRclJDQ29FK2dxMEVNN2Jr?=
 =?utf-8?B?dk1RUzhObmxkYnRqMjk3Si9Hb0s0UDAxeUk1OWYzTERhdXZINkkvSHJMb3dv?=
 =?utf-8?Q?1GPrBeg2s4GTyMAnp2CL0eEgLokEzzkk1/O78kocr8=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(35042699022)(14060799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:46:36.1539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e567b709-b20d-496b-8c53-08de5e7c098f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11626
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6344-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim,glider.be:email,kemnade.info:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C12EBA32E8
X-Rspamd-Action: no action

Multiplexer subsystem has added generic helper functions for getting an
already selected mux-state object.

Replace existing logic in probe with the equivalent helper function.

There is a functional difference in that the mux is now automatically
deselected on release, replacing the explicit mux_state_deselect call.

This change is only compile-tested.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/i2c/busses/i2c-omap.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d9f590f0c384..f02d294db42a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1453,27 +1453,16 @@ omap_i2c_probe(struct platform_device *pdev)
 				       (1000 * omap->speed / 8);
 	}
 
-	if (of_property_present(node, "mux-states")) {
-		struct mux_state *mux_state;
-
-		mux_state = devm_mux_state_get(&pdev->dev, NULL);
-		if (IS_ERR(mux_state)) {
-			r = PTR_ERR(mux_state);
-			dev_dbg(&pdev->dev, "failed to get I2C mux: %d\n", r);
-			goto err_put_pm;
-		}
-		omap->mux_state = mux_state;
-		r = mux_state_select(omap->mux_state);
-		if (r) {
-			dev_err(&pdev->dev, "failed to select I2C mux: %d\n", r);
-			goto err_put_pm;
-		}
+	omap->mux_state = devm_mux_state_get_optional_selected(&pdev->dev, NULL);
+	if (IS_ERR(omap->mux_state)) {
+		r = PTR_ERR(omap->mux_state);
+		goto err_put_pm;
 	}
 
 	/* reset ASAP, clearing any IRQs */
 	r = omap_i2c_init(omap);
 	if (r)
-		goto err_mux_state_deselect;
+		goto err_put_pm;
 
 	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
 		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
@@ -1515,9 +1504,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
-err_mux_state_deselect:
-	if (omap->mux_state)
-		mux_state_deselect(omap->mux_state);
 err_put_pm:
 	pm_runtime_put_sync(omap->dev);
 err_disable_pm:

-- 
2.43.0



