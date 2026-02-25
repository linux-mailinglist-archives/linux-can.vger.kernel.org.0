Return-Path: <linux-can+bounces-6631-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH8DLd3nnmk/XwQAu9opvQ
	(envelope-from <linux-can+bounces-6631-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 13:15:25 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A331971F4
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CC43301C5A6
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941953ACF13;
	Wed, 25 Feb 2026 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rOyIk4k1";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rOyIk4k1"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023112.outbound.protection.outlook.com [52.101.72.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD233A70F;
	Wed, 25 Feb 2026 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.112
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021681; cv=fail; b=Ugkxn/EnmM5slduJj7eG4ATYR2c23kgAJrRwgDV4x3h/sZp4TUqxCmBOv8vC8L4tx5GwRL45EjJ4vuI+FuCuIDfz4OcOGGKUomiIPE/eNPccLLFZfGZfa4AQH9l8VJyy4/vrX0aLJpVCaq8UNexqrvnnLG4WON0K29grVPUsBys=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021681; c=relaxed/simple;
	bh=QD0Yp8226afaoEZNoXuHRHP0TP4fbczuiCs0+6SJp9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ULMcEx/1zqmsx8c+eHm9xD1TMrJoCN9UPjpyhViFWoODo22DYl48Z7umMqou5UBCiw0NBuzlYu+y8Zdn6hskm4Jz83wh7dOpR8TTNgq4BmKv9LVHoX31PIK4U7lJs7KvzwDIQ3/7CQFoaWpYu5MSTPygigJfE5Yq9NDnXlEYkY0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=rOyIk4k1; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=rOyIk4k1; arc=fail smtp.client-ip=52.101.72.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uurg/5vnOt0P7YUD9eYn9amCHDMmZMYFb1JaNSz8J8z0sGrWmS3PhaZKeYMA0OxhVa83OYGdSToFEVDWRSVFc+Uoyx+EgjYZPm2XaiLYQI2FeaGFQ+J+PD4WNKS186BOuVVdxWqp/ChWaCMGjssBNmYMcj/g3CmF3cJ/vsoCjdUIoH3vYA9IQqg/4NFqfXYXv6Ye7VpOloJlvtFAB24ezbJP9zyxzxx78FDMxS81AF1df/a1wy+liY4xZ3FsWIp3PLFGzXIKQ3N8QV4Robk/t24mIjt2ayLRRkU1qaae3BsQxzAevlDrVlzZ6cCq7jajAC+qCKskL+FUqBFccvOOOA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD0Yp8226afaoEZNoXuHRHP0TP4fbczuiCs0+6SJp9E=;
 b=JXclLP7hX27Bepr8v/CreQfHIf6fD1LGV3lctdP3QGrioSlvEuW8Dg5XyxzGcCkezly5m93A+PWLr+6j/WPQSLT3UfMikpC1um1ER16vb4SIpsJs8CkObRs+wDTZVrnN0S/MY/TgXWjGzn/SMxyWl10KT+MMquPLLYAl/FTJ6LpO58fdIKzXf+ZPNb5ipTnTM3FrSpXNutlVsFB/garYn2Oe9JhPadN+vKhHFLNczrcXZ/P+jKl9lGNYZbaK38KouHinprbW7nKuqYItcHXF7TTjr+Iy1UB0DXr/N9xIH4vIU1Qwj2zpxqOsUuIIrkTQKVTT0nqod20ajGrdefSRmA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD0Yp8226afaoEZNoXuHRHP0TP4fbczuiCs0+6SJp9E=;
 b=rOyIk4k1P586yd+/kjpO13Cza4rsN9zfSZHR7/zQEx0dNoGx3N1PevNITW9dRYCk8yttq6un9bAAwhEtUp5bWtf2aPZue25mG4oxvT2fTUN3ng7nDE+8mXMaw9gHeKS6bCNrvNB/597tNzbPNz2bpl2cUJvICHyKaegTFcWOE8E=
Received: from DB8PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:10:120::27)
 by AS8PR04MB8372.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 12:14:36 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::66) by DB8PR06CA0053.outlook.office365.com
 (2603:10a6:10:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 12:14:36 +0000
Received: from emails-7511324-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-66.eu-west-1.compute.internal [10.20.5.66])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 20DCF80619;
	Wed, 25 Feb 2026 12:14:36 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 12:14:25 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPhvi5WXkMHL6YWg2v4oHi/LQQHupVWTjzOaSZncaSbS5pi+N5Z2EFIHQPNVz8wUlxAmV15LOhhUHVIrMzBPp694VmW9cJFtcBluIQAZsHTivgi967KOPAuYIOhxMn8L6AzXByZ3NeDaMzdC9yYNf3uGd8HY+NLvXLcNvYpsTmM6QwE98wS/cEmNEX06scBXGKaFIpg4+uHtxB6+LefUjxefAUtE193Rc60NiyGBobo5tkS+LP4agUMh7klPoW4oChZ4PRkHs8tbMmCP1PO6jM7ZRnmf5U5MxY2Kb6aJEnGA2mIVK6rD1VZeF6UYJsQRD4DAZH6LfyWUZ+raTz+QQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD0Yp8226afaoEZNoXuHRHP0TP4fbczuiCs0+6SJp9E=;
 b=BFEBynUq1hu/8wXIAGwuhZLlWBdr98qPSJ0t8pbVqC58Tx0USXAN5MTac+iac5DYyRi28SJVfNUHfH7ImXmDggHItFyDCa+rWBMuHHxnYlfEiiCeejGGLi3dv2W/LkdlXI+wf6ZasTBTsPtpQhdMPNbFaTTDylMVcOS+CBQfWZbTblFmNsM9H/uFy/GTphs5AvBm0EV3kIsBIQOkurk2hofYXo4GFnllpysNT82b/hzF6J0oSWg/sC9suBKUSN8mLeT1nCHq9lgFL1OGyE+PO5MMjsqv2o/Se84zhKEWuCKyAx2ePBiDZQru9K5UbGZNabSTCpCCsAMVbEFc1ZJ+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD0Yp8226afaoEZNoXuHRHP0TP4fbczuiCs0+6SJp9E=;
 b=rOyIk4k1P586yd+/kjpO13Cza4rsN9zfSZHR7/zQEx0dNoGx3N1PevNITW9dRYCk8yttq6un9bAAwhEtUp5bWtf2aPZue25mG4oxvT2fTUN3ng7nDE+8mXMaw9gHeKS6bCNrvNB/597tNzbPNz2bpl2cUJvICHyKaegTFcWOE8E=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DU2PR04MB8632.eurprd04.prod.outlook.com (2603:10a6:10:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 12:14:22 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:14:22 +0000
From: Josua Mayer <josua@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R
	<vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton
	<jon@solid-run.com>, Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin
	<mikhail.anikin@solid-run.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v10 0/9] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Thread-Topic: [PATCH v10 0/9] mmc: host: renesas_sdhi_core: support
 configuring an optional sdio mux
Thread-Index: AQHcpkqz3n9olZHyDEiHtKNIIa/1HrWTU+8A
Date: Wed, 25 Feb 2026 12:14:22 +0000
Message-ID: <64d52953-9567-4603-86ce-a2b59ca99fd8@solid-run.com>
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|DU2PR04MB8632:EE_|DB1PEPF00039233:EE_|AS8PR04MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: e58eea23-704f-4044-33be-08de7467712e
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 IPeui6N8EXmfdUNKMasQAJOyMWhjk+HXP8B9xuYZ3S53A/MZt1H9erkM7AzD9uf+ZYtXvpi26JVpYhQF78eWDwQGDEWdwHb54jL1YQAl/PqmAEVaVDoehnAMqa44bP3LW2vHJUG6tAlkaA6B6XF4iVYl7JBO2eeNaVsqlclN60jIRs7AW4ty0OSFZ76zmzEYoMAAIY/uvVSvobxdEOTwsOv7rv9uF5bwST5Ek1OTyt5ncut2kXmgS/llP4wFv9lmNtWtGahdUbESzyVoBjy97ijG9v0g+X1fHWE1RFQk6JUvuxNF6BX712KL2nLoIt5W2AJVfSkI/1SM/DjKmHpBekc6jw7ylL30cz9OT4qwUdF0CpB1iquwgbXNA4BFvv7DQUazadUuF4uope/iC3XOC561VAyS+RMdrr7Ks4PlikmfjHeF3VnVb69zgLdIDKWzlROX8Q6YOZZm7pHdWit4XTFlw7/XP4M/1s/a0lYENLsYBpCp/VHUTRhlMG7r6PZZ3IrGl8eORkSPfR7nOjv73p95EBpaWwSDrgZaLhb0+C6jr/Jm9PUs9NJyACIB4ACP7rZegApN/4F3H4P/z8e5X6/7k9jyUvatyIgN1AKvTbbVGAkFJ/MQu8a0QB9uvi/CDlPNvqeRbX9n2yLxVmkgv/OwnPGSyUUqINcTE9GOta0zsOkUt6DuoiX0gIee+/zs8tKv1s1PAhzW54Td9KR8UIL+tkeLfLfBjdzxCD/gaqKi/TG8j7NIMu0WULtvUTy2PihTEJrfKPf50V/hUAFcNfA3rgLUqekpZ3X2sk8i5glUghIpmITkrwZUAvfpKsqd
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DA6AAB8CD3BE24B8E95642CA876772E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8632
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 58d6a62017b24864a5ac97ee908553aa:solidrun,office365_emails,sent,inline:8989a1a0ef2b960aa6fa7fc0ff0ec37f
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d8ffdb01-7941-46fd-b4a2-08de746768e1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|7416014|1800799024|82310400026|35042699022|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	eLJgjMvBx3eniCV/1xg4mg1yE7H80lr3JuhQGZUyXMWNkdDe8uPZwp/WYnivkzh7Rz77bWeP8blZdmo3WRzkZi7QML1SKkcGNY+1G4XnotcLZA9DriYEyculTzfklgRnAdpldS1d2b14qiVKcIxVSinNZJ1Hht4XTbiaIKcsP5OjYHIj0xkf64+ls3GdtqG/swa8Qw6SHh3YaptABmeEH6y9+JSUagOxd4HjDouMeZoCVBNhBiVhw8BxVelrE4rdrhuEUR3CXZKpBeKsP7+FhjEwOnKfgKNA91Jm+w1TmDAlEbUkZgVlsOdzCiOyFTSeS0GBtqOr66fLoO4IVjajp+AVQ0YTavAq6USUzX/opK5POgzEiyS+l+Qj+ylP9qsdolg0N0IIHLDV+9vnO14ypIfG4avhbl83LdcRoooDoeEFPAhwzQn+uP3mBgP5LBeS+aZHbdHvHsmw50HgXYlqqL3DJkfhgqnG7QtJNEByrP3URnZvdo0mWyFXG43HErhD7TBLC/4fs/SIB1QcFCaS+lg/tYjvLhhVlpgnRVwYCgADqew+A+/1WAKWFl5ww47Be6soABCe1ZiBjoBdYO7MaGNLEsJ8JcXz0CSQ9VBBpxa7ATL6bMzjWP+a7ZEbk67U4E7oMqYtVbQH30qFunVHb+FmiFuLQa68BGw7N6Hl8H5gI/UHRHBdRbJitByY2sj8IgrMD1mEPr5xwq29KQDs50so384mugGwQ6DLInNJhpL9ssD0P0p0KQ/a7/BJrF2E9yrTJE/6d8vMOP+Vn+fNc0amIXvIIiA4ZzNtOcdtrq8HZFMths0X9zpaO77kLopcAuyJdB07Kojiw424ygo+Fk+jlMKelFbjESy2RbHaQXI=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(7416014)(1800799024)(82310400026)(35042699022)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cl7+xjCawZ5MENfG8xkPRHfYMG2Jy1wnbUL8wAABDNawUH+ZZ72+nFeILvJWkzgyg56tIA9Vj7OcIjQdbtxCcoFzwtrYN3Zk69dvlmxYvOb8ve5nHBsloaJpt2hOmezS4mMikz7lhwgy4Tlyr+6dC943GhsaEaGow0uKOcIMRsM5Cfk3rhXAtWcPvQFUjBbmRlyCfuzytf3a87ZE/JSPOQmsSVjMp+Jy1ojNoPPTUtdc4AW/XFwZ3B1TaZEmFT0QaUOyZEAT04bxTZpakqVtBAHoCYIbXXmQ41up98Y08LqX8/aFF352EA2z0wOfffvGRvjHqUfJso3XmP5PXMSYHiBqwsCLl77kIfgPMVkFYrT4FzXtuPMvSPmdwqKLktc1m0wG2ZDKtszyxheZ2I0RICnQ40GyXn/6AMcdjoLa+UqoOC2/M9JUDuAxPKGU6M7Z
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:14:36.2075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58eea23-704f-4044-33be-08de7467712e
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8372
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6631-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,gmail.com,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 46A331971F4
X-Rspamd-Action: no action

QW0gMjUuMDIuMjYgdW0gMTI6MzQgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gVGhpcyBzZXJpZXMg
aGFzIGV2b2x2ZWQgb3ZlciB0aW1lIGZyb20gYWRkaW5nIGdlbmVyaWMgbXV4IHN1cHBvcnQgZm9y
DQo+IHJlbmVzYXMgc2RoaSBkcml2ZXIsIHRvIHBhcnRpYWwgcmV3cml0ZSBvZiB0aGUgbXV4IGZy
YW1ld29yay4NCj4NCj4gU2V2ZXJhbCBkcml2ZXJzIGhhdmUgc3RhcnRlZCBpbXBsZW1lbnRpbmcg
ZHJpdmVyLWxvY2FsIG1hbmFnZWQgYW5kDQo+IHVubWFuYWdlZCBoZWxwZXIgZnVuY3Rpb25zIGZv
ciBnZXR0aW5nIGFuZCBzZWxlY3RpbmcgYSBtdXgtc3RhdGUgb2JqZWN0Lg0KPg0KPiBtbWMgbWFp
bnRhaW5lcnMgaGF2ZSByZXF1ZXN0ZWQgdGhhdCBuZXcgY29kZSBzaGFsbCBpbnRyZW9kdWNlIGFu
ZCB1c2UNCj4gZ2VuZXJpYyBoZWxwZXIgZnVuY3Rpb25zIHRoYXQgY2FuIGJlIHNoYXJlZCBieSBh
bGwgZHJpdmVycywgYXZvaWRpbmcNCj4gY29kZSBkdXBsaWNhdGlvbi4NCj4NCj4gVGhpcyBzZXJp
ZXMgaXMgc3RydWN0dXJlZCBpbiA1IHBhcnRzLCBlYWNoIG9mIHdoaWNoIGlzIHNlbGYtc3VmZmlj
aWVudA0KPiBkZXBlbmRpbmcgb25seSBvbiB0aGUgcHJldmlvdXMgcGF0Y2hlcy4gVGhpcyBzaGFs
bCBhbGxvdyB0aGUgZmlyc3QgTg0KPiBwYXRjaGVzIHRvIGJlIGFwcGxpZWQgZXZlbiBpZiB0aGUg
bGFzdCBvbmVzIG5lZWQgZnVydGhlciBkaXNjdXNzaW9uLg0KPg0KPiAxLiBSZW5hbWUgZHJpdmVy
LWxvY2FsIGhlbHBlciBmdW5jdGlvbnMgdG8gYXZvaWQgbmFtZSBjb2xsaXNpb24gd2l0aA0KPiAg
ICBnbG9iYWwgdmVyc2lvbiB0byBiZSBpbnRyb2R1Y2VkIGxhdGVyLg0KPg0KPiAyLiBJbXBsZW1l
bnQgZ2VuZXJpYyBkZXZpY2UtbWFuYWdlZCBoZWxwZXIgZnVuY3Rpb25zIGluIG11eCBjb3JlLg0K
Pg0KPiAzLiBDb252ZXJ0IGRyaXZlciBsb2NhbCBjb2RlIGZyb20gc2ltaWxhciBwYXR0ZXJucyB0
byB1c2UgdGhlIG5ld2x5DQo+ICAgIGFkZGVkIGdsb2JhbCBoZWxwZXJzLg0KPg0KPiA0LiBDaGFu
Z2UgbXV4LWNvcmUgS2NvbmZpZyBzbyB0aGF0IGl0IGNhbiBiZSBlbmFibGVkIHRocm91Z2ggbWVu
dWNvbmZpZywNCj4gICAgd2l0aG91dCBhbiBleHBsaWNpdCAic2VsZWN0IiBkZXBlbmRlbmN5IGZy
b20gb3RoZXIgZHJpdmVycy4NCj4NCj4gNS4gYWRkIGR0IGJpbmRpbmdzIGFuZCBkcml2ZXIgc3Vw
cG9ydCBmb3IgbXV4IGluIHJlbmVzYXMgc2RoaSBkcml2ZXIuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2
MTA6DQo+IC0gYWRkZWQgcmVuZXNhcy1zZGhpIEtjb25maWcgZGVwZW5kZW5jeSBmb3IgTVVMVElQ
TEVYRVIsIGF2b2lkaW5nIGJ1aWxkDQo+ICAgZXJyb3JzIGluIGNhc2Ugc2V0dGluZyBTREhJPXkg
YW5kIE1VTFRJUExFWEVSPW0gaXMgYXR0ZW1wdGVkLg0KPiAgIFRyYWlsZXJzIHdlcmUgZHJvcHBl
ZCBvbiB0aGlzIHBhdGNoIHRvIGVuY291cmFnZSBmcmVzaCByZXZpZXcuDQo+IC0gcmVuYW1lZCBw
aHktY2FuLXRyYW5zY2VpdmVyIGRyaXZlci1sb2NhbCBoZWxwZXIgZnVuY3Rpb24gdG8gYmUNCj4g
ICBjb25zaXN0ZW50IHdpdGggb3RoZXIgZHJpdmVyLWxvY2FsIGZ1bmN0aW9ucywgYW5kIGRyb3Bw
ZWQgYWxsIHRyYWlsZXJzDQo+ICAgZm9yIHRoaXMgcGFydGljdWxhciBwYXRjaC4NCj4gLSByZWNv
bnNpZGVyZWQgdGhlIEtjb25maWcgY2hhbmdlcyBkdWUgdG8gaW5wdXRzIGZyb20gbXV4IGNvcmUg
YXV0aG9yDQo+IC0gaGFuZGxlIG5ld2x5LWFkZGVkIG11eCB1c2FnZSBpbiByY2FyLWdlbjMtdXNi
MiBpbnRyb2R1Y2VkIHdpdGgNCj4gICB2Ny4wLXJjMQ0KPiAtIHN0cmVhbWxpbmUgcGF0Y2ggc2Vx
dWVuY2UNCj4gLSByZWJhc2Ugb24gdjcuMC1yYzENCj4gLSBMaW5rIHRvIHY5OiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzIwMjYwMjA4LXJ6LXNkaW8tbXV4LXY5LTAtOWEzYmUxM2MxMjgwQHNv
bGlkLXJ1bi5jb20NCj4NCj4gQ2hhbmdlcyBpbiB2OToNCj4gLSBjb21waWxlLXRlc3RlZCBvbiB4
ODYgd2l0aCBNVUxUSVBMRVhFUj1tL3kvdW5zZXQuDQo+IC0gZml4ZWQgS2NvbmZpZyBjaGFuZ2Vz
IHNvIHRoYXQgQ09ORklHX01VTFRJUExFWEVSIGNhbiBiZSBzZWxlY3RlZC4NCj4gICB0aHJvdWdo
IG1lbnVjb25maWcgLyAuY29uZmlnIGFzIGludGVuZGVkLg0KPiAtIHVwZGF0ZWQgdHJhaWxlcnMN
Cj4gLSBkb2N1bWVudCBudWxsIHJldHVybiB2YWx1ZSBmb3IgbXV4X2NvbnRyb2xfZ2V0X29wdGlv
bmFsLg0KPiAtIGZpeCBidWlsZCBlcnJvciBmb3IgQ09ORklHX01VTFRJUExFWEVSPW0sIGZvdW5k
IHdpdGggeDg2XzY0DQo+ICAgYWxsbW9kY29uZmlnOiByZXBsYWNlZCBpZmRlZiAuLi4gd2l0aCBp
ZiBJU19FTkFCTEVEKC4uLikuDQo+ICAgKFJlcG9ydGVkLWJ5OiBNYXJrIEJyb3duIDxicm9vbmll
QGtlcm5lbC5vcmc+KQ0KPiAtIExpbmsgdG8gdjg6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyNjAyMDMtcnotc2Rpby1tdXgtdjgtMC0wMjRlYTQwNTg2M2VAc29saWQtcnVuLmNvbQ0KPg0K
PiBDaGFuZ2VzIGluIHY4Og0KPiAtIEFkZCBkZWZlbnNpdmUgbnVsbCBjaGVja3MgZm9yIGFsbCBu
b24tb3B0aW9uYWwgY2FsbHMgdG8gaW50ZXJuYWwNCj4gICBtdXhfZ2V0IGZ1bmN0aW9uLg0KPiAt
IERvY3VtZW50IE5VTEwgcmV0dXJuIHZhbHVlIG9uIGFwcGxpY2FibGUgZnVuY3Rpb25zLg0KPiAt
IEF2b2lkIElTX0VSUl9PUl9OVUxMIGFuZCBFUlJfUFRSKDApIHRvIGRpc2FybSBzbWF0Y2ggZXJy
b3JzLg0KPiAtIExpbmsgdG8gdjc6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjAxMjgt
cnotc2Rpby1tdXgtdjctMC05MmViYjZkYTBkZjhAc29saWQtcnVuLmNvbQ0KPg0KPiBDaGFuZ2Vz
IGluIHY3Og0KPiAtIHBpY2tlZCB1cCByZXZpZXdlZC10YWdzDQo+IC0gZml4IEtjb25maWcgY2hh
bmdlIHRvIGFkZCB0aGUgbWlzc2luZyBwcm9tcHQgZm9yIENPTkZJR19NVUxUSVBMRVhFUiwNCj4g
ICBhbmQgZW5hYmxlIGl0IGJ5IGRlZmF1bHQgd2hlbiBDT01QSUxFX1RFU1QgaXMgc2V0Lg0KPiAg
IChSZXBvcnRlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4p
DQo+IC0gZml4IGFub3RoZXIga2VybmVsIGJ1aWxkIHJvYm90IHdhcm5pbmc6IHVuZG9jdW1lbnRl
ZCBDIHN0cnVjdCBtZW1iZXINCj4gLSBMaW5rIHRvIHY2OiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjYwMTIxLXJ6LXNkaW8tbXV4LXY2LTAtMzhhYTM5NTI3OTI4QHNvbGlkLXJ1bi5jb20N
Cj4NCj4gQ2hhbmdlcyBpbiB2NjoNCj4gLSByZXBsYWNlZCAvKiB3aXRoIC8qKiBmb3IgZGV2bV9t
dXhfc3RhdGVfc3RhdGUgZnVuY3Rpb24gZGVzY3JpcHRpb24uDQo+IC0gY29sbGVjdGVkIHJldmll
dyB0YWdzLg0KPiAtIGZpeGVkIGNoZWNrcGF0Y2ggd2FybmluZ3MgKHNwYWNlLWJlZm9yZS10YWIs
IHZvaWQtcmV0dXJuKS4NCj4gICAoUmVwb3J0ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbikNCj4g
LSBmaXhlZCB1c2UtYWZ0ZXItZnJlZSBpbiBtdXggY29yZSBtdXhfZ2V0IGZ1bmN0aW9uLg0KPiAg
IChSZXBvcnRlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuKQ0KPiAtIGZpeCBtdXggaGVscGVyIGVy
cm9yIHBhdGggdW5pbml0aWFsaXNlZCByZXR1cm4gY29kZSB2YXJpYWJsZS4NCj4gICAoUmVwb3J0
ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPikNCj4gLSBMaW5rIHRvIHY1
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwMTE4LXJ6LXNkaW8tbXV4LXY1LTAtM2Mz
N2U4ODcyNjgzQHNvbGlkLXJ1bi5jb20NCj4NCj4gQ2hhbmdlcyBpbiB2NToNCj4gLSBpbXBsZW1l
bnRlZCBhdXRvbWF0aWMgbXV4IGRlc2VsZWN0IGZvciBkZXZtXypfc2VsZWN0ZWQuDQo+ICAgKFJl
cG9ydGVkLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcuY29t
PikNCj4gLSBiZWNhdXNlIG9mIHNlbWFudGljIGNoYW5nZXMgSSBkcm9wcGVkIHJldmlld2VkIGFu
ZCBhY2tzIGZyb20gb21hcC1pMmMNCj4gICBwYXRjaCAoQW5kcmVhcyBLZW1uYWRlIC8gV29sZnJh
bSBTYW5nKS4NCj4gLSBmaXggaW52YWxpZCByZXR1cm4gdmFsdWUgaW4gdm9pZCBmdW5jdGlvbiBm
b3IgbXV4IGhlbHBlciBzdHVicw0KPiAgIChSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+KQ0KPiAtIExpbmsgdG8gdjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyNTEyMjktcnotc2Rpby1tdXgtdjQtMC1hMDIzZTU1NzU4ZmVAc29saWQtcnVuLmNvbQ0K
Pg0KPiBDaGFuZ2VzIGluIHY0Og0KPiAtIGFkZGVkIE1VTFRJUExFWEVSIEtjb25maWcgaGVscCB0
ZXh0Lg0KPiAtIHJlbW92ZWQgInNlbGVjdCBNVUxUSVBMRVhFUiIgZnJvbSByZW5lc2FzIHNkaGkg
S2NvbmZpZywgYXMgaXQgaXMNCj4gICBub3QgcmVxdWlyZWQgZm9yIGFsbCBkZXZpY2VzIHVzaW5n
IHRoaXMgZHJpdmVyLg0KPiAtIGFkZGVkIHN0dWJzIGZvciBhbGwgc3ltYm9scyBleHBvcnRlZCBi
eSBtdXggY29yZS4NCj4gICAoUmVwb3J0ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRA
bGludXgtbTY4ay5vcmc+KQ0KPiAtIHJlZmFjdG9yZWQgbXV4IGNvcmUgbG9naWMgdG8gc2lsZW5j
ZSBFTk9FTlQgZXJyb3JzIG9ubHkgb24gb3B0aW9uYWwNCj4gICBjb2RlIHBhdGhzLCBrZWVwaW5n
IGVycm9yIHByaW50aW5nIHVuY2hhbmdlZCBvdGhlcndpc2UuDQo+ICAgKFJlcG9ydGVkLWJ5OiBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPikNCj4gLSBwaWNrZWQgdXAg
dmFyaW91cyByZXZpZXdlZC0gYW5kIGFja2VkLWJ5IHRhZ3MNCj4gLSBMaW5rIHRvIHYzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUxMjEwLXJ6LXNkaW8tbXV4LXYzLTAtY2E2MjhkYjU2
ZDYwQHNvbGlkLXJ1bi5jb20NCj4NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSB1cGRhdGVkIG9tYXAt
aTJjIGFuZCBwaHktY2FuLXRyYW5zY2VpdmVyIHRvIHVzZSBuZXcgaGVscGVycy4NCj4gLSBjcmVh
dGVkIGdlbmVyaWMgaGVscGVyIGZ1bmN0aW9ucyBmb3IgZ2V0dGluZyBtYW5hZ2VkIG9wdGlvbmFs
IG11eC1zdGF0ZS4NCj4gICAoUmVwb3J0ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+KQ0KPiAtIHBpY2tlZCB1cCBiaW5kaW5nIGFjayBieSBSb2IgSGVycmluZy4NCj4gLSByZXBs
YWNlZCB1c2Ugb2YgIlNESU8iIHdpdGggIlNEL1NESU8vZU1NQyIgaW4gYmluZGluZyBkb2N1bWVu
dCBhbmQNCj4gICBjb21taXQgZGVzY3JpcHRpb25zLg0KPiAgIChSZXBvcnRlZC1ieTogVWxmIEhh
bnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+KQ0KPiAtIExpbmsgdG8gdjI6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvMjAyNTEyMDEtcnotc2Rpby1tdXgtdjItMC1iY2I1ODFiODhkZDdA
c29saWQtcnVuLmNvbQ0KPg0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGRyb3BwZWQgbXV4LWNvbnRy
b2xsZXIgbm9kZSBmcm9tIGR0IGJpbmRpbmcgZXhhbXBsZQ0KPiAgIChSZXBvcnRlZC1ieTogQ29u
b3IgRG9vbGV5IDxjb25vckBrZXJuZWwub3JnPg0KPiAgICBSZXBvcnRlZC1ieTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPikNCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzIwMjUxMTI4LXJ6LXNkaW8tbXV4LXYxLTAtMWVkZTMxOGQxNjBmQHNv
bGlkLXJ1bi5jb20NCj4NCj4gLS0tDQo+IEpvc3VhIE1heWVyICg5KToNCj4gICAgICAgcGh5OiBj
YW4tdHJhbnNjZWl2ZXI6IHJlbmFtZSB0ZW1wb3JhcnkgaGVscGVyIGZ1bmN0aW9uIHRvIGF2b2lk
IGNvbmZsaWN0DQo+ICAgICAgIHBoeTogcmVuZXNhczogcmNhci1nZW4zLXVzYjI6IHJlbmFtZSBs
b2NhbCBtdXggaGVscGVyIHRvIGF2b2lkIGNvbmZsaWN0DQo+ICAgICAgIG11eDogQWRkIGhlbHBl
ciBmdW5jdGlvbnMgZm9yIGdldHRpbmcgb3B0aW9uYWwgYW5kIHNlbGVjdGVkIG11eC1zdGF0ZQ0K
U2VyaWVzIG1heSBiZSBzcGxpdCBoZXJlLCBhdCB0aGlzIHBvaW50IHRoZSBuZXcgaGVscGVycyBo
YXZlIHplcm8gdXNlcnMsDQpidXQgbmFtZXMgaGF2ZSBiZWVuIHJlc2VydmVkLCBhdm9pZGluZyBm
dXR1cmUgZHJpdmVyLWxvY2FsIG5hbWUgY29uZmxpY3RzLg0KDQpUaGlzIGlzIHRoZSBtb3N0IGNy
aXRpY2FsIHBpZWNlLCBpdCB3b3VsZCBiZSBnb29kIGlmIGl0IGNhbiBiZSBhcHBsaWVkIHRvIG5l
eHQgZWFybHksDQpwZW5kaW5nIHJldmlldyBhbmQga2VybmVsIHJvYm90IHJlc3VsdHMgb2YgY291
cnNlLg0KDQo+ICAgICAgIHBoeTogY2FuLXRyYW5zY2VpdmVyOiBkcm9wIHRlbXBvcmFyeSBoZWxw
ZXIgZ2V0dGluZyBvcHRpb25hbCBtdXgtc3RhdGUNCj4gICAgICAgcGh5OiByZW5lc2FzOiByY2Fy
LWdlbjMtdXNiMjogZHJvcCBoZWxwZXIgZ2V0dGluZyBvcHRpb25hbCBtdXgtc3RhdGUNCj4gICAg
ICAgaTJjOiBvbWFwOiBzd2l0Y2ggdG8gbmV3IGdlbmVyaWMgaGVscGVyIGZvciBnZXR0aW5nIHNl
bGVjdGVkIG11eC1zdGF0ZQ0KU2VyaWVzIG1heSBiZSBzcGxpdCBoZXJlIHRyZWF0aW5nIHJlbmVz
YXMtc2RoaSAmIG11eCBLY29uZmlnIHNlYXJhdGUuDQo+ICAgICAgIGR0LWJpbmRpbmdzOiBtbWM6
IHJlbmVzYXMsc2RoaTogQWRkIG11eC1zdGF0ZXMgcHJvcGVydHkNCj4gICAgICAgbXV4OiBhZGQg
cHJvbXB0IGFuZCBoZWxwIHRleHQgdG8gQ09ORklHX01VTFRJUExFWEVSIG1ha2luZyBpdCB2aXNp
YmxlDQo+ICAgICAgIG1tYzogaG9zdDogcmVuZXNhc19zZGhpX2NvcmU6IHN1cHBvcnQgc2VsZWN0
aW5nIGFuIG9wdGlvbmFsIG11eA0KPg0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3Jl
bmVzYXMsc2RoaS55YW1sICAgICAgfCAgIDYgKw0KPiAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1v
bWFwLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMjQgKy0tDQo+ICBkcml2ZXJzL21tYy9ob3N0
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL21t
Yy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMgICAgICAgICAgICAgICB8ICAgNiArDQo+ICBkcml2
ZXJzL211eC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOSArLQ0K
PiAgZHJpdmVycy9tdXgvY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAy
MDYgKysrKysrKysrKysrKysrKystLS0tDQo+ICBkcml2ZXJzL3BoeS9waHktY2FuLXRyYW5zY2Vp
dmVyLmMgICAgICAgICAgICAgICAgICB8ICAxMCAtDQo+ICBkcml2ZXJzL3BoeS9yZW5lc2FzL3Bo
eS1yY2FyLWdlbjMtdXNiMi5jICAgICAgICAgICB8ICAzMCArLS0NCj4gIGluY2x1ZGUvbGludXgv
bXV4L2NvbnN1bWVyLmggICAgICAgICAgICAgICAgICAgICAgIHwgMTA4ICsrKysrKysrKystDQo+
ICA5IGZpbGVzIGNoYW5nZWQsIDMwNyBpbnNlcnRpb25zKCspLCA5MyBkZWxldGlvbnMoLSkNCj4g
LS0tDQo+IGJhc2UtY29tbWl0OiA2ZGUyM2Y4MWE1ZTA4YmU4ZmJmNWU4ZDdlOWZlYmM3MmE1YjVm
MjdmDQo+IGNoYW5nZS1pZDogMjAyNTExMjgtcnotc2Rpby1tdXgtYWNjNTEzN2YxNjE4DQo+DQo+
IEJlc3QgcmVnYXJkcyw=

