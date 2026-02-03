Return-Path: <linux-can+bounces-6476-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLVODfvygWkMNAMAu9opvQ
	(envelope-from <linux-can+bounces-6476-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:07:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E4D9A91
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99AB33108743
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3F350D7E;
	Tue,  3 Feb 2026 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="W4hACIKN";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="W4hACIKN"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020121.outbound.protection.outlook.com [52.101.69.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4F34D4E0;
	Tue,  3 Feb 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.121
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123736; cv=fail; b=mFPWxXiszoTrhawgkcsfGqIzG6wWmqKOWZsDe6Es9Mz4LXf6ASGgIvzKqpAJERtZ0nPSY62xmadNnIlNbXIYnuiKjJThRjWNtFo9CcHvNdaUH+ohYbDnHm3BEbPcLxZYIbX0pB2OXKLu164EqVYPLeKtimsczTi4L9a/Wa+c1wg=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123736; c=relaxed/simple;
	bh=H+dxOlw7D+/ac+pzWaD9F9Ao/kAHfSrb2565gnhAQBo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n29iaY3S6WRiJuItC0Z13TZVF31Ey6kjJxsJUBB31A9yIFbvu/p+u4nIXAGZLA8OSHEh0fsDiFmGP+fSII5RZzrh278suiOxsggOJbs1E+TlFxGzwSehbyrswxzTLvzMQRlfgo9F2S5uSNP/g8zwFOq4cUXrKZ7/E/o8pzIGJTA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=W4hACIKN; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=W4hACIKN; arc=fail smtp.client-ip=52.101.69.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ROGJdfLEo34KmUVegF3OdWo0UTzPyKFPPHJ2IWYNTrJr8NxY8G+rOOlu0717bJmR2EIS3klajT1JVyzE2rD2hSYzhg4iBo3wcKuOuWFEKjfVQZL0qlYRJDxfxxNpc09c3hE1ChFnVe2FSXNNTSOnADxOGz2mQeUjZc06ZsnTc5myvSlnPmnGZD6n0ZOI9693iSNfrW4qVSwBxdytBEVQZC3Xy9jO0osDqxZK34rJcNZKJw0Q9EqWfE28XvwmpQZOKIe9ZefkeMbCbwUsIwU9AV0asj0AiqMtU7htg5xyismmIM40mxyNPPchY3Ss/Fx+wtUkIsHybc/gX/D+JvI6Ng==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=PhEi4PVObg76571bsxHYdTmyLh9BCcJcp1OrqWnMhQYa5J8yozBOZ3rSGwq4cuchFJq/aP9RMbJhrK+gDA9n4ZQ8XtEJwRT7QBU2109sPTIR2lCA0l/pQffr/qk2Df92kC3QVoN8G7w13+k/SjLcOCQQNIT4ZIUl7u1Tv4Fih5PGdEAYHHw6OjCrZN5FS8pQRx7j5rfhTaufizKY2Skk8fJGLbFHNBoLx7n9KH2gw17d0r48j+THKbaRbTBhoI671LAH1lnOFnotYnQVXUt8Z8l02ZeXc0RdZSUE22AURdvbyJLdTVXbPfpK2Q5qcv0O8YQG5V6NnbBuS4DvFTx+aQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=W4hACIKNXTihThnwkKzTmS/mp68X+QX/7GorfYZa5DZF2qAUiRZhgNa8TRXcRCPMEPzrr7JJNKXfoFuYft1/mla2s2MWYyHd53+im4WcoTHsTgBc/b7cO6K2bN41fJC30S2UxZLHFnNR20n9LO116YRXr76TVS0pu9Ip03zE6Bc=
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by GV1PR04MB10584.eurprd04.prod.outlook.com
 (2603:10a6:150:210::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:02:08 +0000
Received: from DB1PEPF0003922D.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::b6) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 13:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF0003922D.mail.protection.outlook.com (10.167.8.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 13:02:08 +0000
Received: from emails-5095661-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-224.eu-west-1.compute.internal [10.20.6.224])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 4DA1B80546;
	Tue,  3 Feb 2026 13:02:08 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770123728; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=YfHTLYnH0yZY0dGMLzQQw91FR5gIjqLEetlwxUk6QTRMkNAwHgOgyxO0Ma3aWmVfPOJrB
 yCZaabe0eMfnjoEJz+19KKiE/pneBYTnpIE7KjzBETZk13cIbR/G+23xM9cYdJHpU/zx3Hy
 BLaCqQXu6LszLc7S+niHGZ6jNU1cPkU=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770123728;
 b=YMyyfIMCsib9w8UUr97nkMi3UZCPwVfxNqdJztYezCWA5dB6dYJnnYrggfFRGD2spfRUY
 Srb7yTDedWbaLQQKUmWFbtSYxh0Qa1zZMpsqJsHDCmbi5LecBl8bjZForcePony+uuur/S6
 sITM1RT97o6QEvV/VgE3vp/XuPDLXIs=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgdaAXAgJqTZUGCqMe5OjVSGxoAiF1dhM3RW2Y0dw8XkVuL4lC0x8bSCeuqDhRHawirVuXuFiK/7r4yYf+ma205ZP/Dyqt+yofDRFX22EUiLZ0gM2+GlY+41JAEV3xxzoOp6UxXOktO9zpXbxe6ihZo78YxNL0cFcAp4KcEy1p/4hDf1f//ba6hOeRpSvMP0foznxO0W6s9aEEt/Tie00MwUMM4hFiaWxzbhSLgbchmn0jwp6EqeOiShpZqI4hQpI4HHm6o+zU2g0TeFq2fkT/XUK+js36+ujJF7hriQTICC8HB7XdWRGwuD2JcMPM4WBrCO6Pizs91dJBonxldJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=wk7N30hepWZ5H8eapd2SLUTxD+jaFNsw37rJjfZ1/2ZcDZuBt1MBesozPehYz0sz/ynHnaYdg6cHgJSCekVPW9WzmaqduyFggPARAFtYrGQ4w9QgcNwKzyqIrQFMRPeg/JekE3b5+BfjeEn3JtXkDV3X+nUnnlePrEB93mACNxP4T0cfBmSxqFBREvYoD/Qwpgig1pzHHTCYVpdORdAvmB1ks/durReIjmwRvgvpAe066EOY5Jmu6Y+HAHa6fNXl7bbSN/WCeUrXaZOrOWyO55kdpfmDIOrdlPIEsr6wbr/3QwcvxuldvgrG6VM/Q5Z924YGJRxSMjvuViBJ/dG8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=W4hACIKNXTihThnwkKzTmS/mp68X+QX/7GorfYZa5DZF2qAUiRZhgNa8TRXcRCPMEPzrr7JJNKXfoFuYft1/mla2s2MWYyHd53+im4WcoTHsTgBc/b7cO6K2bN41fJC30S2UxZLHFnNR20n9LO116YRXr76TVS0pu9Ip03zE6Bc=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:56 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:01:55 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Feb 2026 15:01:39 +0200
Subject: [PATCH v8 6/7] dt-bindings: mmc: renesas,sdhi: Add mux-states
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-rz-sdio-mux-v8-6-024ea405863e@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
In-Reply-To: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
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
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AS5PR04MB10041:EE_|DB1PEPF0003922D:EE_|GV1PR04MB10584:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f17fdbd-e0f0-401a-51ed-08de6324702a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SEdTVGVhZEVXc0JURHpIMGttU0hNbEZDbGdlQjZCS01CWFVwSnV6TE1nWmVr?=
 =?utf-8?B?RnYwTzZZM2dTNVhCelptSVZKU3dBbS9iZmlkVHlhVHBUclp4cWJVb0RmdGRT?=
 =?utf-8?B?NjRWM2oyQkMwblRiZkxlRkVIaEFzeGNYTVZFZFd2dGlER2tES0RCcE5rSHV6?=
 =?utf-8?B?VFdMUEtCczZkVkMrcGtxL2RPMXpYUE52bUx3UHFyVFlBc3Vuc0daOUNDTkEz?=
 =?utf-8?B?Zkhoc21GZlZtUFFxTW1YTnV2TWR5OEdFUmNvNFpUamE5b3hKZ1hvckZXNUd0?=
 =?utf-8?B?VDg4WTY3MjBTd0hWWGpuZVZsMkVDMVZ4ckRPNVFHUzFWTkpZVHZ0RUlyeFdF?=
 =?utf-8?B?aEE3dElmMHYrRXMzRXFtT0RsUC9RZHNYRVVNV0JoS29hMWdoL1NpcFhLeGQz?=
 =?utf-8?B?THUxYUp2dmJZcVBtTFNBVytwL2c2WUkza3N5MHp1N3lNUnZqT29jZnpGR3dq?=
 =?utf-8?B?NXJnc08xMkVRbEV3aFNBQkdwNmlYNVBGZjN6eEUyZ0FkZ2Y3Rm5iRUYwMWI0?=
 =?utf-8?B?RXdkK0IyVGU0S0txbThKNXlPelJUaE04a2lLMmVYSmlsWlkwdTJrNnNleW0z?=
 =?utf-8?B?S29uTzhNY0VtMmFmSG94Vkw0QTl2OFNzSVFYcVRVdTdtV3VwbDZuSHFIdXJR?=
 =?utf-8?B?NEN4Mldpb01PNmdzRGNjbDg1SkNiUVJyTFBPckRoNGF0UTdVQmpVTXFsOEJl?=
 =?utf-8?B?SWE0cE4vek04MVZtcHNNNm1lK0dHRnJHeEEvRldmM3F2N0xrR3VlV01yc2tK?=
 =?utf-8?B?YnlmNjI3VzBCMHVHT3B5aWJjOVZNWTRYWit3cS91MUNhT3dsLzFRRDByVG15?=
 =?utf-8?B?VzRIRmVOd25zZ3FaVzlIK3dLaDhYbENGQ01QODBjNmd4eS9Kak5hVDlzUmla?=
 =?utf-8?B?a2prNm1KM1hnTDN0TXNhV1Bmb1JJckxsQTdDcjBFWFI3NVZCWmhCRWVrT1hX?=
 =?utf-8?B?U3VFN3VCb1YxUXRoN0lDRmR5VnNUSHhnYzJ4R3VUYklNbVZmeHEzNXJtZEMy?=
 =?utf-8?B?cDIyTzBpV0gweUVhQjJnSFk0L0dKRTZNSzhGRTBZbmxTNnl2WTlERlRmZ3hN?=
 =?utf-8?B?bWY3OEkrd1BGVG8wQTZJeC8xNHNhY3NJVUtWNFYyTUh0YTlNNTVKZG4vN1pF?=
 =?utf-8?B?cWRLMk5rL1ptQmZzeCtUMStIU2VKbkozWjNxK0VQWjc5SEFEWGV1RUhCUjZE?=
 =?utf-8?B?Vzc0c09SSUZEM24xRkp3THRxVnRvcU03V25YRlZYQ0V6b25qZlRpbzF0Y3lI?=
 =?utf-8?B?R1RvMk40SEVxK05HTUtDK1RsZmVOZHF2blprdjdnNDhqc013OExuMkhDRW5N?=
 =?utf-8?B?dDAzQldFcFFXdTAxWlhwbTVhSjdiamRLdlpVU2tkSGY0T3loSDNMeEl3RGdp?=
 =?utf-8?B?UHRoSktWRFhtam5DODZFQjhKc3FqVkJsdlNiME41akRIUWpRNks1L2JvTW01?=
 =?utf-8?B?REJsWVdwWUh2cmxYK3hia3cwSzhLdmVTUnlIdit0WlZ1dS9mMS9DUWRkQUpJ?=
 =?utf-8?B?K3RHek1ndy80T05KV2s3TmUwZDlFaVJHeFNERGpxWnBpdGlydFdqLzY1QjN5?=
 =?utf-8?B?OXFFNG9mWHEvNExzRTJlaVZwVldDeC9neWlDL1E1Zk1YdThQRDVUR1I5S0oy?=
 =?utf-8?B?SktzYU5CYUxvRVRWZmVrYmU2VDdxMUwzbFg4OVlnRWF4bDFNNkFzaHJSV3Vo?=
 =?utf-8?B?MU02cysvZzNIS3E5SHVoaFhsbkYwK3poRWdzV3Z4R1hCYXB3OGdueVBpT0xR?=
 =?utf-8?B?OWVCTkdnTndtdmxqWmNQRUEvd0FXUUJublRrbVlRWnVna0QzVkRkaU5LSllB?=
 =?utf-8?B?UFErVHFPYTN6b21QZ0FINjd0V09wb2ZRcTNWc1BGbEhFalZBcVlmMHk3QzFm?=
 =?utf-8?B?bDBXL2hLNHlmTVdkNzZ2Wm5uN3dMdjFzQlppZ09NS01VaG9IZHhJMmhGcW5p?=
 =?utf-8?B?R2VKQXFVc0tsWkVwRGdkbWR1S3JVVFVSUkFCRWg3V2h0ZERzbFlNS2p4UTU4?=
 =?utf-8?B?Mjl1NS9hTURSSGxOVXJpTXMrYTJpb2ZMaWVpRnJZRnF4SS85bWNmZm5MT2lI?=
 =?utf-8?B?SjJodFFydFhmVkpPTStUV0NyVExsV0VBNWIvb1FnU1BDbW0vSTM0M2ZDSVEz?=
 =?utf-8?B?SjNCT01talpyNERaY0xTbDVZOUhGcWlFYmNiNE5xeGlCZ015VFlFbkdCbEgx?=
 =?utf-8?Q?sxelTQ4hnRcoacQGKitsfy8096fcygLipYnxfSvJBTD3?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: de8e708a27194d9a86a13f274fc28781:solidrun,office365_emails,sent,inline:325c726d7bb4eee7ea0486ee39a741b0
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4de24c29-253d-484f-24a1-08de6324682a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|376014|7416014|82310400026|35042699022|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlgxeE1KTmdkeVBiSzN3YVhtQnhsRkhtUUNvbyt0MWVVN0ZvNUd3S0lSR3Q0?=
 =?utf-8?B?ZmxLbFRLak9zeUw1VU9zTmdIZzNOb09ZdWgyTUdEMmJpak9nR3pQWVRKWUV6?=
 =?utf-8?B?cW1IOElVZmhjdURtQnphU3l2ZldVcHZXQXhpNnkrQ1lHdVRuSUJqRStzK3hr?=
 =?utf-8?B?WmRyNzdJcGRJa0JCYW5QQ0gxblJ5dXdxai9wd1VDRE5xUkVTUG15ZjdBS0Z3?=
 =?utf-8?B?cXZZSzRtYkFRUW1lb2tjdmlMb1M0d2lzRDMwdWVja1hncFBjRmdPbTByM2hE?=
 =?utf-8?B?MVZyZ215cGNlSW5iaU5OeGNhcHFaOFB4cSs0T2ZJd0pRd20wbEQzbXBYSDQ2?=
 =?utf-8?B?TnhvY3pOZEliU1psdkZUZlNKRzNrSmVLVXY4QTJHNHUvTGRLN2ZJdEZDQUJB?=
 =?utf-8?B?ak5UVE90OHFJYU5EQzRscEk2TUludSs5eTk2WVFFRGlRVEdvS09xbTFNR3V6?=
 =?utf-8?B?em9PK1RTc2RrcVVzUGFKZzBoOGFDOUVpUldUUEpYTDVhOVdFVDIyejRWajlh?=
 =?utf-8?B?MjJwQkoxVVp3blJ4REw1dHNvVU5TRXFzV0NlYWhuNS9oN0dDNkZEYlpiOUR3?=
 =?utf-8?B?SEsvOHdjK0ZMWGU2NVNTa0hpN2NhVUF5UDVYTGdKc01KZENTNEUrdUlMQmhH?=
 =?utf-8?B?ek5KU2RDVloxOHd0ZXJjeGpXbE9rVTVaTS9ERUFKYVQxbFJzR09MVUpGWDBy?=
 =?utf-8?B?UGQybGplSTFIaHFHOHdJTE0zUEJXTzAveGZFWHcyelloYVVURFJsWE1LVzEx?=
 =?utf-8?B?VTN4cHlpcWRDc092NElXM0lKNC9aellHNDZHVTNIWVR2ei9wT3lxcmRMWXVV?=
 =?utf-8?B?bXFTd002b3R5ZytqdnVUOGNUVnRNSGV0N0tVTGR6RnRBY01wMzJHektYajc5?=
 =?utf-8?B?RGQ5REUvdWlySFRkbzNybWlsVGttd0JQNk9YRGdlZWd6UlMra0V4QXlxbTZK?=
 =?utf-8?B?bFdmOGxLdUVVcGFNQU5QNUQ4dUJiQ09VNVZPSFRMMjNBR3AvZko3NU44SEpJ?=
 =?utf-8?B?QmMveDZVZytBSFZtKzVnRUNJVkdPL2w4MnRVa1ZoSUxKbE4xbCt6ZGxFRVU4?=
 =?utf-8?B?WkhHOXF0UG9DQ1NuUUN4K3c2VHRWcGpieDlRNEI1UlVldkFaMEJQRC9YcUc3?=
 =?utf-8?B?bzZYTjF0dUFFU2srVUpBejJ5S3Arbm9Jd0drbEs2V2djT2tQTDc3eW9nbmxl?=
 =?utf-8?B?Q0l6UGRqOWlSQTNna3h2eGtaOU93UlpWdWxHR0ZCdHdIc1hRL1pWTlhVMXU3?=
 =?utf-8?B?d2FTZllUK0kvVm9WK3RodXFnZ25jckJ5N0pkeVF5MC9lNWxmUkl1SFhvNTdP?=
 =?utf-8?B?TmJTM0pGUWc3ZVhqMWt3Nk03dTRaOVV2SzY3QVpyZUY0NlpVbldpN2NLcWNU?=
 =?utf-8?B?QlZqd0VwandWMVRyRWFQMG9SemNxSTRPSFpiMDdWQ1BKQkhsY3JIejRveE9i?=
 =?utf-8?B?bjYzL2hoSHRiRHZPODhuK2pnVWlDS0pDeUZ0bG5lNFAxOVV3ZmErOGUwM0hS?=
 =?utf-8?B?Zi95dDlhcE03NldCTmlFZ0J6VFQ0YWNxTDF0YkkxNUJERWtMMWVkWDJiMS81?=
 =?utf-8?B?eUsyNHdwRWt3cWZGbUdGTXd5ZlVRTGM4TDg3dTBGbENWT2JCbVlTSWFPelFl?=
 =?utf-8?B?b2FEc0pWM3VjSkFMZUxGWm13NWdSZnVTNVRZWWxmaUQ0VUllaCtHU1VWWlNY?=
 =?utf-8?B?NmkrcXN2MTFJODgzYlF1eThMRFVpbTFCeXpucS85dWJYTjFKYkpWV09CUjQy?=
 =?utf-8?B?bHdmbjVDaXpLN0R2bEs1U09yRDU5NWE5YmxzemQ2NmgzZ1ZwTGJHVjlWWFhq?=
 =?utf-8?B?YkF4WlMyVVkzSTV0dnh2c1dxRWxyNkFxRW1tR2VYRFh2cDJ3ZVRvckZqeWNG?=
 =?utf-8?B?c1dQYm9kdGlYU0FqZm1KZVNoSGt6NGEyTkloYXllWlFHVVJiajNqSjVIRVdZ?=
 =?utf-8?B?eUlYS3VGYjBpN3QyQ1hOemtHRlBHZFRWL1lQc21xOWpxZWZrUmJZWmo2K3o4?=
 =?utf-8?B?N0tucmpNbXdLQmVDZnF6UEx2enZvbmZ6OVpYdVRHRDA2cHRST2U3dkxNYjBa?=
 =?utf-8?B?dzN3bUk3dzZoQS91V3Zla3p5bmk5THVMSVY1dEV1ZDRsSUlNS0hLdHMwblZ4?=
 =?utf-8?B?dU1CdFdQMVFtQTRLb0N5Z1BTQlpHTEprYWFTUGxRVmZ5ZmhFZkFvWVUrc1B3?=
 =?utf-8?B?Ymh0QVJVRkd6UzlzeEVlcU8rSVVOVmlvVUk4Sm1jYWoyZStqcEJHclF3amNE?=
 =?utf-8?B?dktGZ3dTem5qWXB0Y1lzUjZkd3RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(376014)(7416014)(82310400026)(35042699022)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B4OIrNUkZ+Kbf7DG+F26ALPhmdSFsTpet/XSyN8P9g65Pc8MILX2y5QGZAjx6zD3vMY4cd2o8Fm0rZDXarGLy9BGIShA1yf66pRZouthOWmUIZqZbn6Guxhto5/ZFc+9CIs8OYQrzLSN5GrSjaCwUDPowwoe4z2CFUAVWetyP/BwQ2rqXXhVYhAbqEsViF4uqIVD2/LEVnHvdOZCXAUbAOnVJT2cXQdTbkVv9QLuSvYZLHJpvFZjAIX7LfHdWVKXHVbZC0EgQ9LtP2N4FBhcdj9c2pPGx42lajVhGUw5mq1u+XaYJKzv8tBgRJ0CUJXbbq43qSyCmRiRWFMuPDqnY2Jj0Bji/9U/zVcJSNpTMBsTZKm9+zd+sLAndvghE1RV60cmlBCOdDYV2r/FoAldn29MhlxKQDx0KrhNMQRBxz6PYSSrnzywiWcPLC6Iu42j
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:02:08.4551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f17fdbd-e0f0-401a-51ed-08de6324702a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10584
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
	TAGGED_FROM(0.00)[bounces-6476-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DA0E4D9A91
X-Rspamd-Action: no action

Add mux controller support for data or control lines that are muxed
between a host and multiple cards.

There are several devices supporting a choice of eMMC or SD on a single
board by both dip switch and gpio, e.g. Renesas RZ/G2L SMARC SoM and
SolidRun RZ/G2L SoM.

In-tree dts for the Renesas boards currently rely on preprocessor macros
and gpio hogs to describe the respective cards.

By adding mux-states property to sdhi controller description, boards can
correctly describe the mux that already exists in hardware - and drivers
can coordinate between mux selection and probing for cards.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index c754ea71f51f..64fac0d11329 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -106,6 +106,11 @@ properties:
   iommus:
     maxItems: 1
 
+  mux-states:
+    description:
+      mux controller node to route the SD/SDIO/eMMC signals from SoC to cards.
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
@@ -275,6 +280,7 @@ examples:
         max-frequency = <195000000>;
         power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
         resets = <&cpg 314>;
+        mux-states = <&mux 0>;
     };
 
     sdhi1: mmc@ee120000 {

-- 
2.43.0



