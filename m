Return-Path: <linux-can+bounces-6507-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ16IrCuiGlTuQQAu9opvQ
	(envelope-from <linux-can+bounces-6507-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:41:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182E109458
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1508304DE93
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4A36680A;
	Sun,  8 Feb 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GOtPZDjj";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GOtPZDjj"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023111.outbound.protection.outlook.com [52.101.83.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92EA366801;
	Sun,  8 Feb 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.111
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565170; cv=fail; b=WUDBqFWoFRDnxgyOdSTryb+iDO0tdmOzuLPgVeZa8dlodASe/Tdzz/Y95lYn+DWB25BWxiwcBOxvikW+CKELIPLVYIn424VUGw5Q82xDILXnapTf8WaZR5C0jR1sRRJstFqQiv1kL/e8XF09SCOYPzEDoKPraHJJIUKKhCqMnJM=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565170; c=relaxed/simple;
	bh=EiycPCNkiYnw6lURDciYeTpSQH2tmn6O2DZT/yLyL+c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LPvTBGjRwNpHzvKTzG8bXXQKezMXejtmkvPycEcslDpnsH9CDne+MzP/3Wds1a04vK9MBHMPjjeaPq51c/vObFYILrCSPLqFf9YkdgL6xWnVgmcHoJ7iR4bsgDT/O+6EzEMrljHaKaPlqzAFOA4uT4GSAH1r4i/nr+k1yBcj9ro=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GOtPZDjj; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GOtPZDjj; arc=fail smtp.client-ip=52.101.83.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=caZvm/uz0mPeYZ0rz3sjEUzchwFTerO/0vZQ9jtyuKpQQCmwEOwuweDV+fOH9LdK9hrK+RddO2HdIOxNmqhX7Guvg85fmw+ltg357zOqCson/B/PGfz5pX5DTnyfS+xkM5dBj7XEg6mvHQhLeJA36GbnVHGksYOYPBg1ilNjaoPC6HmMdulkvDlDgaCQrpakksXPEdN24Ru/fYqgU83ILEnlFh+oOIGVPFkSlS/5mRlxZXHKwBkEgw8NBjz9IKMwkT4gpa3n0iVhXCy3YtqPPyIP0jtgTnToqa2ggObmoX39bxBqfmvpgF5ynVYZR6uaMeaxQHBB62X0WGTiAUHJlg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=R4wXJAQNvAkYmb9eMxwgqWMIzm7od3uc8uiSM/N/l+JDMUgqKIyBZ+gbcIBuh8AC2Sb8dKwhK+sGSnykOuyVeD2oUmkzeuFwZ7YZ6kiLBrZGnyarLTB+/Au7V//d1vpbikSYsF315TemObmL1ZQZoqfuserw+9UYCmjuNbeqgVepfa+i0arVVOTkZPcWV+yB5NsE7pX++QpztwEIu+X0eBEl1dYRU52mNzdD7RYWEPOi/0ZOKQoN3RDiPRPpyxGnIV0JOw/ZkKiRdRAMRnFzQdnqxMaM9zfoo4qS/syXk09kAHJ0sUnhcsynTqke2I+H45WHcFxl8Jx/J6h7ilmNIQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=GOtPZDjjRL9mu83bGiiLyXAYFxgs/fJwAT9rYCOUWBO0Wfm3BHvz6P9gt0huwkwPxN2e3DZ+ekZzzkgg9lNA1ZoWKnfHgjCE++/HEXVthrjztwXb+l2nX4APYjniHzTZhVLad6D/M4n/mwfBRRCHeNe1WsYscA1K1WgLtxlcHEM=
Received: from DU7PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::14) by DUZPR04MB9846.eurprd04.prod.outlook.com
 (2603:10a6:10:4db::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:26 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::9b) by DU7PR01CA0027.outlook.office365.com
 (2603:10a6:10:50e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 15:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:39:25 +0000
Received: from emails-3684086-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-47.eu-west-1.compute.internal [10.20.5.47])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id B92C280085;
	Sun,  8 Feb 2026 15:39:25 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770565165; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=B8FFLXVuFhdZ/OjCYcymmyBB5tW0CQSwitVAu41ySDD3ptHvxM0Rxiy+9BJyq3YZQ0Svp
 A9/P+ASAjuy527iYfeo2lRh7NNlgszIy7A6plUa+wFtAVnqnNbiMjdA5ekXnTdK5SMksVRU
 +ZjT95RXNNUjThZgf9jDdCz0IzdmZc8=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770565165;
 b=SsBDesdhU2whbPKJqDOfQd/rAocmpfEXf6mlY2rIgEtUByWbsYTIW6uTDUwHgIbPmrhIg
 wBCfkfr5VQ5TDHDpqw0XCf2SC1FIGzqjx+1kmgdZ9+6ahI8+XjqttRH2oekvdx8pCZipPT2
 MVuRMqOpI3ZWE2O/gzFR5OtBr4LDKvo=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ml1heOPwN9tCrPHwow3IhYMtGpHVb76Lid+yjZKn2ISDZv9sE5Uh/OP/Zf+D92IfG8LkGqiiN+zhPJm12wnGzKZt5LjrC3PqQ1LmRGME9WxHU7UBkfyDjb9TA++Mk/5WlitxXoGLf+tRZLcPx8ib/HrfqqiO2gUfopv1RlmMx8rraNkU37ILXvG5WayLCPPtaCmqdXSx6/LkuBi9o2IfCjEjNw6QeITC4fMN1BDO4jK27zoClohDs8w4BHNdstk6Eug/kHSiNNh4vW5Ay/NYjWoGF0gwyn3Hm0Qff2IJtJvAXopczHmLzu6Orzuc9PUWX6XXRyQcvo1wAE2HAQL7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=vWFk5/p9UVcc1i+pMEis08NdfsYvG4ptBNSpk//zfCWR3hBXSCYqhoF5jjVVUwTJ1U/ZIQ4u9s4VNzr3SUQyDBLBCnhssTY28zwYkAnoNLhuJr5ZMHbtYX66N9gORGdkgpAhsOKjtpr9rEY97IHF55l/Pd13ude5C2AXqAW48VNNiuw0EWphI90fBgdFMNWm6fRSTfAexqvUh+mitMqzxJET83sgGttMGSiePMyHfpiC8S6hsysMWJH1HTd5BiXzgSIfN5HZs3Bx7uFIpPLAIrPJvnKnuay7NpE6vz3VjoXQupZ2clbq3X9VNcMvKnC+d1ZAbuX0D314VEgoXGy3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=GOtPZDjjRL9mu83bGiiLyXAYFxgs/fJwAT9rYCOUWBO0Wfm3BHvz6P9gt0huwkwPxN2e3DZ+ekZzzkgg9lNA1ZoWKnfHgjCE++/HEXVthrjztwXb+l2nX4APYjniHzTZhVLad6D/M4n/mwfBRRCHeNe1WsYscA1K1WgLtxlcHEM=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:16 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:39:16 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 08 Feb 2026 17:39:00 +0200
Subject: [PATCH v9 5/7] i2c: omap: switch to new generic helper for getting
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-rz-sdio-mux-v9-5-9a3be13c1280@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
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
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB9074:EE_|DB3PEPF0000885D:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: bc386172-789a-45aa-0b71-08de67283d55
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|7053199007|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZUJRcWtidmNxNFdVcURja2kxVncrdFIxaUdZMDRwTGgxTW84RjRHNGlQT05r?=
 =?utf-8?B?eTY0eFNubFpzRmVGd09yYmVMdjl0aFV6RHhUUHlVNDE4ZFBpYXhnTXBJUHUv?=
 =?utf-8?B?Rm0xV2piRFlKWVIvQWczWGltOEwwK2xSbVJ3U09DMnRScENyUkg0cnZCbXFB?=
 =?utf-8?B?K0FWTzJsaGxYc0haMjQvRVVLNm8zejh1c09SYjMzNEFkcW9QWEV3bFFkNG5P?=
 =?utf-8?B?czViaTMwY3RyTHF4OHdnZ1RIWEdsRzVLMnlWeFJLRmFnRmJrVDZYWGlpZzZy?=
 =?utf-8?B?VElGeFhPRFcyNzRJZmxGWTdveW0zN1Z6ekFQaDFvNm9GazBvbVdlVXVuc1Rl?=
 =?utf-8?B?N1MwSk8xTEk2Smt3N0F4NnhvaXB0SVpuR2Y0S2FNVG5uQ09HV1FiRm00Qmk0?=
 =?utf-8?B?SDltdzdtWFcrMFBvV1FVYTNPR0ltMjhIWTE4cWx0b0ZpZUQ1dTNSZVNQVGNs?=
 =?utf-8?B?NUNBVDN0TThlbllvMGNYRFVjdkFaQUxqclZ2UnlwN2Q2ekJpcmt4ZXlvbThv?=
 =?utf-8?B?SkhzODJrSjQ4cVRnaXp3SzZaL1kxMkkvQkRJakxLV08zM0FkN0dsMjNGSjBl?=
 =?utf-8?B?Rnphd2VvRFRlQUM4Q1FRZUxZTkFXSFJJcnh2eUVKbGRyU01IdFZ6VEwxS0w3?=
 =?utf-8?B?RGFnVlM4TlJHQk9WR1RpdzllTUpZNDREaXZScjgwcGNKeGkzY1N1TUJuck5I?=
 =?utf-8?B?Q0dQeUZlc1dJRWRLN0E4cGRJQTcyTmlTWmZFS3A1ZlMyUUFNM2cyRWl0RW1h?=
 =?utf-8?B?Q0NCT3d3S0Q4Y3lTdkJXdG5pTldiajVUSXhyc3kyLzFBNDA3VTBFYWM0VVRs?=
 =?utf-8?B?elllcnA1OXUwUHlQcllveXJGT2E5UmZDbCt5SGdBMmllb0V5TytDNFRHY1BW?=
 =?utf-8?B?SjQreUVGaVlGSEpEc2F5ZEYvalJyQkRXQkR6UVZSSW1yaFZBSlJSYlhlWkdW?=
 =?utf-8?B?ckJ5aDBCYmdicldybjJnWTgzYWNMMkV0dno0RkZwMGxCczVHZHJyUGN1NS9C?=
 =?utf-8?B?VEh6NG5Lc2owOU9yQ3puNlRpN3p5dys0cUlZVXVNNEtTTEpEcXdLTm5ENUdi?=
 =?utf-8?B?TWtVUTdzT1h0amM0ai8zVkM5OWRwTnIxMDZtK1JVeHhhYUcxcWxkOUZBRGxH?=
 =?utf-8?B?dHBpVk5lcFRxUHFsN3YvOHp5WDhFMmlNaG5XUmxPSU9RTlNadUNjRjFoK293?=
 =?utf-8?B?UXB0K2RVbTZNcXZsR1BuK3lmVG9JRUtCcFo0NE9jdUlmNmV3ZExObitOanZZ?=
 =?utf-8?B?VzNPMndiMWU5NkFPWFdPVGphUFBSaGNEaUVEcnFWWlVnUnJObFJuVGs0dHlC?=
 =?utf-8?B?SFNHUm91WVljZzByVTNIdS90OVpuWW0zbjRqbTJZUmJPeUtDZTVDZlhTV0g3?=
 =?utf-8?B?YXlQVTJmaHdhd3ZhVGU3bTFiMVVkUTRnVndrZzR3YklyZXhYYUxVYmIvcVht?=
 =?utf-8?B?YlVZSjR5S2NDSU0zbm1oaGJiN3J5QlEyOUhUZkxscnFlNHhHWHZoSzQrWVdu?=
 =?utf-8?B?UmowZFo0MmNPbUU1MHZscDdoaGRVWmc1bFZHa3daa0lzQjdqQ0Z5SC90b1Fq?=
 =?utf-8?B?T1hFbDdSVnU4RnMxa2haYUJvV1ROaTBkL3JtRTZmNVU4YkZHQy9Mbk5tVTdT?=
 =?utf-8?B?bEs2aTVDQlJXOUdham8yRVpDQ2c3UlRHWWhPOTVuL2pYa241WXRkUmhDZklR?=
 =?utf-8?B?QXJIVTFsbDZ2b0VNV0pSUDdUYmw3MFh1RTF1Z05ENDFVZ3FiZmt2WHIvMTdp?=
 =?utf-8?B?d1RWbUJLNENEOEZVUVV3OXRCbUQ4QzRQL2VMTFdHbUovb24vQ2NUTUVJblU1?=
 =?utf-8?B?S0g0L2Fqa3ZubGJ2VTJkTW5UMUcrUTFnWU1Cc0tlWXBwOUtBNFBqWXhYOUhK?=
 =?utf-8?B?d1NkdTJ2V0VNR3JTYjdJdERkY1pSSldWNmV5eVRpV2lCRUFJYzZoSGFCaWtt?=
 =?utf-8?B?aTlGZ2hJVlRBazUvUTBGOGtCbVg0K0NwVFcvUTVuQ2p6Mk9DSzRsSlZ6RXd6?=
 =?utf-8?B?b01ocTVsUkp5a0owTE1CbXc5eUx1KzJjRmVKcWZiNUs1YnJreTc1VG9JejRz?=
 =?utf-8?B?MnFBdlNHdFFnWWxyVjFET08yUHk2aVBZVjA2K3RXRmdtWkVlcGRCQ3FZbFFz?=
 =?utf-8?B?YytkY3NiVWlCWThFSHZTQVpVdzRBZkJOczdpMUZ1eDFxKzE1dWttK3hRckFH?=
 =?utf-8?Q?vN1aii6U/O7MP0xmkbv0Lho0KnGuQwU6Zdnh2ieT69md?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(7053199007)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 6667e42f6835491e85d11acf1bbecc53:solidrun,office365_emails,sent,inline:12b0fcb10f4278561484c091dce66039
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4bbc1fa6-3a34-445d-1d82-08de67283796
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|7416014|35042699022|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG1aZ0Q3bTBOamtuYlBUK2NFQ2lpenlnZmxKMEUvSFc3VmZtZzZ2UHZRMDhz?=
 =?utf-8?B?VlYzK0QrR253VXhvRDhvejBxM2FIRVlwSER2TG1IaVMxV0ovVHFxTGIyYSs5?=
 =?utf-8?B?eE5RT2wxS2pxOVBiQzB6YW9JelRWR1ErQ1hHMzBkcW4ySmZPdEpPdEp5ZXNm?=
 =?utf-8?B?YWNxU2l3ZnFtZGI3dHlnOFVPZHdNM3pzbDZMdHByVERxNXAwaFd3MjFydG1n?=
 =?utf-8?B?Sk5UOEptNHUzQXBKNUhaeWtPemlaaGhOYnRWblpsbTlXYXlHRkFrNStWZ0hG?=
 =?utf-8?B?MEprYjlsbGpmL2Fkd08wbGU1d0JXQUJLMXZ1SndlL1R0dHdwRFljMjljc2N2?=
 =?utf-8?B?bFpjQzQwRi9RTXVkbU5LKzJDeTdEcldVS3liWTAraGcxUDVxODZUUnQrN2tV?=
 =?utf-8?B?c05YVkRYOGZmSHMxTnArUlFzWnFobVhEdm5GSWVacHZ3dVNGZFp1bTZBNXFa?=
 =?utf-8?B?b1B0UlBRUUEwSHh0RjlabjdvTW1keXhmL1FnMEJmNlgxUVduUHU0aEJGWFZV?=
 =?utf-8?B?QkJXWFZCd2p0SUtZUjQ0Z3RzRTFvSHJScEw2N0pSeGU0eHZwK05maEZ6dEJy?=
 =?utf-8?B?T2ozczhJNlIvdG9LMG1uajl5dTRLMFc2UG51OG1GdXBKTEVCOEtab2FyMmRC?=
 =?utf-8?B?Ymt2RERldWtJTjA3cjFyRCtUSzBFa2JoR1FkTEs2SU9GaGtoVGNuSHowZFhM?=
 =?utf-8?B?QVJGa0tpTFNxQlBYNnhPZ0JmZzV0K0RPYk93UDVlWDdySlFkZFMzTm9jV2k5?=
 =?utf-8?B?WTB6Y2NHR1hWclVpTFRIYjFKMmxlUkZZcmxieFBXaXNoNjVRRWhXT2Y0dFg5?=
 =?utf-8?B?VW94YjVVaHZKdy9KSlFzQkxseFcxaER3OEo5L0tmMzF4SysvWHc4Z0FGZWtx?=
 =?utf-8?B?ajQxeElsUURnR0FyNi9FVEpCOTBXTHViUEw0YXUzbEE1TXJOSTFXYmdGOFJS?=
 =?utf-8?B?QmJrc083RzM2M0xZWWNqZW5qVzR6elFKUlBEb21pZDMvdDU2TjA2alllbHVC?=
 =?utf-8?B?T0xpUDg3MkR6ZWdiQk94MHc5anh4T0h3RTlXMkxCQ3AxbllMSEZpUTA3Q1BP?=
 =?utf-8?B?Y29oVHdFMEpyZ0pzdkpURUVSeXBYeDJSZzVCdUt1eEx5dTJQQWVudGplOUVj?=
 =?utf-8?B?ZTc5cEZVbzVVV2ZtMGpTVlk1SFlLV2hMZ0tsUTlhUkViYlNVZHdqQmlKNTJs?=
 =?utf-8?B?WEd1SzhNd3paZmE4bERsR1JDeDZjRFFraEQwb2R0czYrNERadlE5WlQyQVRZ?=
 =?utf-8?B?a21yaG13RHFmd3hrRkNuYks1WUVwRXBKRDBlNjJWdVVnZGx2azVKL2VRd1Rt?=
 =?utf-8?B?SFBpOGxpdk9sa1QzZ1BJeG5ycnNNc3lJb2xjYUx3NUlPUmkzdlhRcWd6ZWxz?=
 =?utf-8?B?S2dSaHVQcHNkakt4UExWS1hXaUNReGU3YTRFa2NFeklJd0RoZU9lTElRMVkz?=
 =?utf-8?B?VEttREtuZmRhL3oyMG1TM1FOaFplVkgxQXNraGwwOFNrbUlJcFdBODMyWUkz?=
 =?utf-8?B?UXlPa2pZbVllRjdPSzRrOTJoVDlkUVlqWlMyK1VlOGZyd21HRllxLzlKdmJS?=
 =?utf-8?B?Mmtpa2x3STlmOENlMEg5N0ZGL2FYUkpobHY3bVpVcmNnVVhOaHRhejBOOGlN?=
 =?utf-8?B?VHA1bklDek1tN2pWK1ZQVzF0R1B3bjc4d3drcy91dklHSE9Va3YrK0RlUzlN?=
 =?utf-8?B?U1h1alVPZGNuYXh1ZlJGRnVZUnZJdEFpeFNrYzgrSjB5Z2NyUkpvTmRlVEx1?=
 =?utf-8?B?clB0VjFGenJFMjlld3gzMUFRSyt2RnlXd3BmSlpGaTR1NS85bkhpbmViemFz?=
 =?utf-8?B?RWZDVWxVTFRzdmlmK0x2ZnpOS24ralIvRWdnT01PM0tYMWIvNHZzRVVzdzlJ?=
 =?utf-8?B?VXFVQ0JFcHRiK1FaT29JczNxeXgwMStuNVYzZVhlcnEzekFVU3Y0YkNzTndQ?=
 =?utf-8?B?d1pOdHF0SmhjYVQyanRjQWk3cHdYeHlqY3JoemFXdDFoTXFsSlNoRDlyNGQy?=
 =?utf-8?B?WHlBd20yQjlxYTBndHZUS1kzRGhGenJ1ZEVSQmhlTmpyYUw1dGs1MVl0TDBl?=
 =?utf-8?B?dkZTT3Q2WFNxejhERXBPQnR4RzJYUFBpTWI3cDdJSmtMekdJa2RSVURUVU9v?=
 =?utf-8?B?amozSEJ4T1RpVVdCbzIyQkw3VXY1MFFKaURZTU5TbTlyN1B0S3pST1crakl6?=
 =?utf-8?B?VjRFUW1qZ2t3TkFuRmw0L3lkbFdQT2N1eFBXaG85M2NNVDlMZERzYUJIaGNH?=
 =?utf-8?Q?nXJlnTfKaUOSySZlxXCO6+RyaMI1h+3iK88WSjWC/M=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(7416014)(35042699022)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J44Y/CzWq309b+hesr+ajFzlhOM6TaYhCeLUxNaoguz0gt6DpfRUmat1qqzSV9RLk55xwjC0HzNT/39vVf3Ki4J4sXzeltILGeY37SRb9uR5saM1MU/i4lT1aZ6ATP11W27/mOrOiNbHW9DeFQtSG20+l0wNUOJ02xDnMymFcSn+a0FdbV6sgpIR6fvmEi9QeryyCiC+2/T24WJys4PD8Tv5z3MZCllK2akuAHGsqe+10euRYW97r0/SP/TmGwEEN5CDNCZiJhaf1Ur8wBdPh63QBmVtuUkmBOw1b3U1vZFvmbgjagkaJW9u3pSMLuyD4Uo2WCZkabhNDU7P+cMUspgLAxFcjfPo4s5mhNHnFSzaiZP4emo93lCrILeWubbm+06czleAqwKIF4J4OpCuybkIgRXoE6prZcTEqqutJeRZkRNq6JDD+y44gRdyd9Rn
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:39:25.8098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc386172-789a-45aa-0b71-08de67283d55
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6507-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:email,solidrn.onmicrosoft.com:dkim,glider.be:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kemnade.info:email,solid-run.com:mid,solid-run.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3182E109458
X-Rspamd-Action: no action

Multiplexer subsystem has added generic helper functions for getting an
already selected mux-state object.

Replace existing logic in probe with the equivalent helper function.

There is a functional difference in that the mux is now automatically
deselected on release, replacing the explicit mux_state_deselect call.

This change is only compile-tested.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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



