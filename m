Return-Path: <linux-can+bounces-7407-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGPeDBJE72kx/gAAu9opvQ
	(envelope-from <linux-can+bounces-7407-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 13:10:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D07C471803
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 13:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FC8A3004696
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C03B6BFA;
	Mon, 27 Apr 2026 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="CdckTTkz";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="CdckTTkz"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022105.outbound.protection.outlook.com [52.101.66.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449A2D6E58;
	Mon, 27 Apr 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.105
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288203; cv=fail; b=FKNxoCV3xsBx4buTYg2bDtuQyVx6bODaVXvW5InCeT22zSXbDpKp1+hvuYkDlKWFKv+SEephxfWyC3qhJ1rzVT2B3vD8tfhDcT9mIlp3pO5vNfJM+5pmmoiD/5UYMdXXY/C9WeLvVLk6Tw+Or7HFFgijfvvKcVJwrN0QlW1jGNk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288203; c=relaxed/simple;
	bh=Gemw7ulZ2szmlhAfYPcv+b/IawzmD4rAnieHPc7BuMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=la+tMrYAcaXIRtwLakvaAWLMm8L0Y95suGqjbJS2F3OeEQ2evLPPqGR3CyoLnpMH8qKyiE0bk/dlIbDKg9b1ZBsSKQ+frSpJrnY8AnSGovAN4F2IJpLapxBi0ITnqGetjJmQE4ktWcZuaGHacuO7GnTl/hMlrNZSF0BGgS/FqGg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=CdckTTkz; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=CdckTTkz; arc=fail smtp.client-ip=52.101.66.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bJ5s6FYjIUnz1bK7WmtdVr4VPUv4BexaPP+YTSdqK9lx3iqWuP93da/jRyEKSxz04kDLO6OBpfNKMKqE523d2l6iQaQGcBqf46jhwTA85oLJVe4411efaUQ6MPIjgjcEoPvFbJ+q4LDsQ4A5WxEync457+eReIdLmt2clAkRNuMFC0CGKpzc2tmSBugGxrkU8rMlc00YJUSpg89nJ47zjB81KjKXTLdoTKylHvR8Lrwum21SJuE/JWiKG5qqEhIM8hVpLXwBt1nm+FP/6VqpKqhZpL8jbdETLiMyQ4gKHdbavh6NsQqHe3VWwv/bmZbqiwGSHkHflSFDZSl2vElBGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gemw7ulZ2szmlhAfYPcv+b/IawzmD4rAnieHPc7BuMk=;
 b=ALhQhep0EecgfjKAcyIM1rvhBebP9ZCKVFKdbKPdozGUKJMK2Vdl8R+VL5SqB0joJjBQywrsuyG+ISr2tvkPxACzUvND4A88zBwpqxDVLOqb2/jm3SuKQQ4ZLwld7CEnq1sBbHyJNvdr2oWGglez1vHcMPUmgBkMWVO7xb9kLRHkYguIIhlZeSiIl3WK9iYCgBFxgVkfVGgSWtQjYyfK8P3Ow8YuUJx1tVCt0GyEzmCeg3YfkD3ZrIprIAAMOTaDPhzu4El693idUyl5cnUS2gPuqc0luJWf4J1pgBaFDlaIrgRRRcV5mKL8Lx9C8+QjQ6fvq+mUCwe8Iz7BdqqZBw==
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
 bh=Gemw7ulZ2szmlhAfYPcv+b/IawzmD4rAnieHPc7BuMk=;
 b=CdckTTkz5zBDE27a3e4P/bpEHK8OFBrLEZQnizEOKSb+LYpPpotglbRf/Fi9rV9zwzgDUv3Gx03/BDSaBmAG4342ZoVcyFLehtmKot8kRfPis66m1y3GQb3/c/tAWWo26wymbBc4+l60enKScxvWbCwuf0EO4V9KXEDSU6wPEx8nfdaPOu90tg5TaaN9w+x8yXkI5fJjvKtvt+TbVWSfJl/5U7ENVemhkgabuhlCLLqjJC+hqtyaEmvMl4k3xb9J33oS65HEY2Vs38SU1vGfbQQeHetX08wuP5a9714hvCpAJDFq4dwaWVEnfs4Oii1v+O3kJv1+YBKopTWm7MMy/Q==
Received: from CWLP123CA0231.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::17)
 by DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Mon, 27 Apr
 2026 11:09:58 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::26) by CWLP123CA0231.outlook.office365.com
 (2603:10a6:400:19f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 11:09:57 +0000
Received: from emails-2017066-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-243.eu-west-1.compute.internal [10.20.5.243])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 067C48054F;
	Mon, 27 Apr 2026 11:09:57 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Mon Apr 27 11:09:50 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Esv+C7UuGykUkDhvHcbjJzM2S0lnMOOeFPzru/7RPE9405mirWQRCbnh7MtqNrvDqTFX3qPDlRJ3N0YF4gkKWdot6uhqA7YlaMREMpDlCWYJLxdsPtfQppPwmF4YqRkt1HPACN1UPl3WAShnRDga/9LILz5a+2AKIEXdnMlgRctqSpgxJwc8VIT+oOunVFaPxzb15RwUplja4lpJNTeLZ1LNq6gMNqWG8BPb53FZLw4etp1LCCXfkEJdmqIebOQu0bNZHlV8GGTwPDtFIQgQdOKvXhAeqaTwXFnMp6VJUf91uk+Z2icBAGmwYVqwMpeqkmi/mG+lGB2KWF8mF793bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gemw7ulZ2szmlhAfYPcv+b/IawzmD4rAnieHPc7BuMk=;
 b=pwAc3mLffllYphT1A/mVA5pqTaeLxmwO53IUMqJOIavEj5964TC4rq1TXAI4fzZ2OAG946uMswLM4zBpTsq2SoS/FzYwjvKB1rZ2zzse4ZaKgzlw3L6mDUPKcrkDgP5mvSyzk4CpkMDhJO23AN5x6rcXUutY51uAzsE+5k4AC19akszj4VlRipDX2byyPYBpagGl5Tr9YeBe641t8K35asUpuAMmWYga2dyoLXOcfAg5lFRlCorGPBMOmwguw8DkEFBaoSRkcIZfRFk5V1GRoJUhPH+uIQYnXj/7GLn+qDOto/HiX6uc/EVnicxyfx2kywcT8vZ84IEdCV9DEFzm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gemw7ulZ2szmlhAfYPcv+b/IawzmD4rAnieHPc7BuMk=;
 b=CdckTTkz5zBDE27a3e4P/bpEHK8OFBrLEZQnizEOKSb+LYpPpotglbRf/Fi9rV9zwzgDUv3Gx03/BDSaBmAG4342ZoVcyFLehtmKot8kRfPis66m1y3GQb3/c/tAWWo26wymbBc4+l60enKScxvWbCwuf0EO4V9KXEDSU6wPEx8nfdaPOu90tg5TaaN9w+x8yXkI5fJjvKtvt+TbVWSfJl/5U7ENVemhkgabuhlCLLqjJC+hqtyaEmvMl4k3xb9J33oS65HEY2Vs38SU1vGfbQQeHetX08wuP5a9714hvCpAJDFq4dwaWVEnfs4Oii1v+O3kJv1+YBKopTWm7MMy/Q==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by AM9PR04MB8421.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 11:09:48 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 11:09:48 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Thread-Topic: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Thread-Index: AQHctkzt2/uGtBr9E0uHhoJ+wJjgi7XfEH0AgBPvoQA=
Date: Mon, 27 Apr 2026 11:09:48 +0000
Message-ID: <7bcb68c4-e4bd-4ad9-bb75-99e0845b204c@solid-run.com>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
In-Reply-To: <ad6KwGIhpJn_2eVz@ashevche-desk.local>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|AM9PR04MB8421:EE_|AMS1EPF00000045:EE_|DB8PR04MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd7d0da-028c-441e-236c-08dea44d845c
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 Ad7y6BnY1b1DbLSgVdPbsiu56Q/67oaJOIlWgdGX68TBi/BsFmm9WDpTT8bstSU41Ajwtlqy8ZZdFsD0DzucAdekYJXkckV2C2S+qALSuNgAHNRuG0vw8QiMow0lkEgziQCfLFrpR+Mz3r4HTGa2hUmUbJP3xmF7GDrNh45sHSy9029VWQGypCQdff9c02pPmO9g0gqjsI95irbnaulWdQaK9tcZ9y/9l4tyINnUgFMX+VdGxj4EXrMiryCbOaIK4CSWQ+mNz/DIdvc9w4bAh34vdIpLSJJF8b8G3D7rFq8TOlFk0ITJ1RiLZ/Rk92DVS3ZJ+S2P1KfuV0PJ+zl1h4GQt7wcfznOSjEUKHin8jdwNtJufDij0pVnXNU1ufyJL1uzWcjNPak8dKUBP4oAOgxVvaQ/MG4V4Zl1+3FciKQvq05y+uiuUjSsCkbx+M4k+xAUXOgm/OIRA7wZXXEFFZuqiwGX4oH8xEgtyIFoM6aDorBM+NfKyVAaui5fSQVf0nuOtdJnhZ5+QnCH3lea1twVFK//+6L+7onl/7WDyJBWvYdovOTy6c97w4KSqA93ZFDeZmkSlD4sPMEKkKa9lgwDh5C55LgOwWHDwIo81uPcJk4xistv21mh26NSwkR4prBvGHvPCstK1278jKthsB7q8DA9ivBoDKKoaU0/+rqCRZrF+JBcRWpFARNMdN6iPBHsZ3ZqdRFe6oOLilyommziUcxfFc2sef2XRHkoWNMOzJ1mkrrJQd6cFeosk4HVVYJn5xvNBozhJnEn/k6pBV5ImhyUsOC/rFDLyHKKpkQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7077A8CB4CBAB4D957D0070BE452BE2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 Ji5erYaNd9Y5djJot7xWibAjwdphDMjQS0tsIOhTvdzyERuEZIkYdzf86zLhqd3Jkb8UUpZ3kcgby1uMDdq2WjSfQ53xHfY+zUmPmto0etazTKLa+ynEnI6kzXT894a8fynfXI9+shRVJW8At6vKXZ9S6/m2rrfm/ZpECSv83MX/ypNj8YWWVWgTDdpAu9cqarAjMQ/5NLT2eEVL3Eao26/rXoOfRidgSTgWmBRDfXgprFCnap7SFjQrXqKICV7RaRuWyWhhPzMCrDl48Yvl7S5o5PcP67QQ6iDFsrebHk7UWhWyC/nlICjrRiI/cW6pUNFcc7Mmga5jzNVAdc+0yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8421
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 0e992435abd64df1a015c3bccd35d997:solidrun,office365_emails,sent,inline:e5f4c0cce52b3aa936fab29a235a2a66
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	89294d50-e1d5-4be2-0b9c-08dea44d7f31
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|376014|14060799003|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yW9LnamEgmOlYXoUTlmxQrcea4fi4F66IZiCQ8wdizUo10QGPNeciQcdSbHSk8R1YmKfxr6rqOr1ZwCanIht2znBBl/T3b0MktwdO3uMvGJ3CQw190+j++0fJEW0WD8mha7a249t+RwNpkzs2WtroOFrOAy8cv3G+kJs/e5kOvLT53ll+TwIMxtz6TMw3YcEokjo2qT5C+AGQGu3swwXz5t01gH1jAeSgbMFpl9guq+Ldx1k3Jcje1qGauw1gzP8uCCO68EypMc51We/NcHg/nE3DvUNFFboCFmy1MRBxAbpi5jqfO79I5CB8JRtoqWSmO7Bnqj/I5Xrp7L4rW1VzWhz/phCDHGzbNp53BdwhCsL52A3i2PYI8BB0FdM1dXvO2N9ZMiEAqwxNebfUM6mO1/0SuFtZBh9kGtL6/c68P0ALHygpntAuZfDQxmvwBiiBdUrYHChOk7Zahvnq5fEpiOYs+VHyVF7HpsraVPqIpfRlU0t07k7DtR2VPROWHS/yE30ED+4/txw6CI+R9XhukwTmVa2s0BJIr7Wg9NoCHgF8sCs2jbLGk0NQRKACLsJ8mgA2dRGk94ibEvGMTL0Vl8FUKW4QzBgzmGNQwPrEOw7SkYZaWpJWHGV+SCUh+yQ8m6xsyxzGUEKTqyqVXFKqDjZDzg0hxEkXSMS0EAqNpHMzcOUfAjkgYoy5nK0EzJki18zVDATuIO1wSm4T2Xc9qXcjvdWX8o1z4nczawholLx0BKt76ka1ZArxDrB5Uz6aMNWd4QfdyHPst6nZSHhzA==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(376014)(14060799003)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e+WwBtO4GWYrkvBd6ron9vqxHz0cDpoBhEmIHHT8M/PK+KvpL7KTiw3Mjann/BebujYssjj0yO3KuFMYAKHzdh60WTxjUye1ZyWVc/ZoOyEmZTMKq6BUWDz9wsYsmz6+sDBp2a3YLSz6KLmbcvcsLX9i5WoKgp5AqtOYcRV4n5kajen3RF+rGYo0UQYTcFMLaGiSknMyzCgVnE2rsxnHkaIS+aMxuQIrDuHAUEFzk+yj1Z9V511xA0Vw9XTmpAFTMaFgh91TiCfjbDNPmw0OeMTfir6lTfVlc4HHg9RMeEti+shldMGXJV6lh3S8GRobwmMfERzi5dK7lrifjB/sBq7eBBn/pGlsLtfSbE/5IUYCKGna73/zISpdHYP8JIFKasutJ2nkUr22L9qG0DsYyhR8ZTXaEtPyLqz4/JubeJq83E9HMhZhoelyF5ymyoCQ
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:09:57.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd7d0da-028c-441e-236c-08dea44d845c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6796
X-Rspamd-Queue-Id: 2D07C471803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7407-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,solid-run.com:dkim,solid-run.com:mid];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[9]

SGkgQW5keSwNCg0KQW0gMTQuMDQuMjYgdW0gMjA6NDMgc2NocmllYiBBbmR5IFNoZXZjaGVua286
DQo+IE9uIFR1ZSwgTWFyIDE3LCAyMDI2IGF0IDA5OjI3OjI2UE0gKzAxMDAsIEFuZHkgU2hldmNo
ZW5rbyB3cm90ZToNCj4+IFRoZSBkcml2ZXIgZG9lcyB0d28gdGhpbmdzIHRoYXQgbmVlZCB0byBi
ZSBhZGRyZXNzZWQ6DQo+PiAtIGluY2x1ZGVzIHN1YmplY3QgdG8gcmVtb3ZlIGdwaW8uaA0KPj4g
LSBjaGVja3MgZm9yIGVycm9yIGNvZGUgZnJvbSBkZXZpY2UgcHJvcGVydHkgQVBJcyB3aGVuIGl0
IGNhbiBiZSBkb25lIGluDQo+PiAgIGEgcm9idXN0IHdheQ0KPj4NCj4+IFRoaXMgc2VyaWVzIGFk
ZHJlc3NlcyB0aGUgYWJvdmUgYW5kIGFkZHMgYSBjb3VwbGUgb2YgYWRkaXRpb25hbCByZWZhY3Rv
cmluZy4NCj4gQW55IGNvbW1lbnRzIG9uIHRoaXM/IERvZXNuJ3QgbG9vayBsaWtlIGl0IGJlaW5n
IGFwcGxpZWQgc28gZmFyLi4uDQpGb3IgdW5rbm93biByZWFzb24geW91ciBwYXRjaC1zZXQgZGlk
IG5vdCBhcnJpdmUgaW4gbXkgaW5ib3guDQpQZXJoYXBzIGl0IHdlbnQgbWlzc2luZyBmb3Igb3Ro
ZXJzLCB0b28/DQoNCnNpbmNlcmVseQ0KSm9zdWEgTWF5ZXINCg==

