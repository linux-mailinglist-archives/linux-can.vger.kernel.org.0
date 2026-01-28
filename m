Return-Path: <linux-can+bounces-6343-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CTHEhciemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6343-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:49:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62FA32AE
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4587C307D0D4
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B260D361DDE;
	Wed, 28 Jan 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="F7BpFR0+";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="F7BpFR0+"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023123.outbound.protection.outlook.com [52.101.72.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A51288CA6;
	Wed, 28 Jan 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.123
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611601; cv=fail; b=LbfSUFEMVicp5vGLRr+RSPAvOItSDNzb/OOvkexHXi03kN4OArn3aTLtMrni+u5KaJxmMU3yE1J6ayRorDFy+aexh0E+U8C5+k5X2FyMkoQFQwx4byYhp7Es/806WiDL7H5vTaFV3B1iGRPnOBufZ5PdRSZgNvU3JgSyHgTKhEU=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611601; c=relaxed/simple;
	bh=sjb5eqgiKJnv5oQS0oIqpitPoO+3g2RRM66VyIKvlUc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iYyDfMHCr2CIzUywu7RBAks3PMt+AJGgnogwju7BWCYoJms4MSNyck5zmaxLnQjXE0+bljqrLM7Weh6v75Eh264DvTV09tZeqsrjHzLH7M9uNrg6x7J+f3H4lNu80dWbR+wRchVoLZe+Vu9yOt7UEobzTn7Ivh5rd3QpCZE5DVg=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=F7BpFR0+; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=F7BpFR0+; arc=fail smtp.client-ip=52.101.72.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q+0L1PQyqLPsVI4GA5pUKt3T9RBfWc8d/txeKXNtsZ2boa4k2aI+Ivyn711EY2vM6zJPPswPB04aoCSvk+58yFf8k0Kkg24dW/rg6mk8rPfyXSjdIns+EQqTl2HG3zFi9Gstjq708aKWmDnIvwWXAPjoASgmHeyrx5ZVl0VFxmgfnpmwcyElCrfOoEeJbOh6FxMXjvSucN4OJvQkguUbgKK/5thOR7lPXCzikAJsOMZLJihpC8hdshFxNeA6U4k+jvVsp468/SkCj/bEWEoJXsKZZmXK4NrJ6GhSA+MeYtgbMMefy2Mh04s+bnOvIGnbkBiVa+7I3EJZYbzE0f53DQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=RIDQ0uNb7pzBFjGsuLAxhcjH9GMGElSP9HfzWhAXgiZaIMejd/abtM4vUauuTmo/SEhHQK9sCntyIxTaBHojFdWozNtZoudrj3MNuILJq8ZPhyyi7bCWvk9+lnuG6gEO8fkOvMb73Ujx+TwFcUPK9yJJkSyjO2IgUU5zILGxl5f+beJX7Aixkgsal3RabX/z1jvJz9huLVMJwf5TAqn2/xH2rynCoC8i46o6DwY+zV+iezObDjf2iARiMWHWJBVTTPklEfMf950YbDkigON0B0/LAQTrrY09LDWZANht12L1rLo/ygw6eVMLBEfb/WvGxXw6CCK2T8KxMby4XP9cAQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=F7BpFR0+xGwtuXYfGWoGdn3oGA3n2S3f30rv+u+cpIcQOJFAYyE/CFBqOvcjMrmxKl5IyRpMZxx6fRIIhEuhoQOWwEE6oh1pw2wAz6Kf7PPf+MwpjTEMEfTAjkM/22iEQ8QI2txoFF2C9ez7Kqh+vgmUWaZhXsVswQtlbRvNeD0=
Received: from DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) by OSKPR04MB11319.eurprd04.prod.outlook.com
 (2603:10a6:e10:98::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 14:46:34 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::6f) by DUZPR01CA0090.outlook.office365.com
 (2603:10a6:10:46a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:46:34 +0000
Received: from emails-96560-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-155.eu-west-1.compute.internal [10.20.5.155])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 7038E8069F;
	Wed, 28 Jan 2026 14:46:34 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1769611594; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=Yk90KGcSTtuqjDNi0BAQVo/ifTpAZlU6zvDlvkCIVnFa7bNIQhNAU12HYfk0a7Zwv+uEF
 odJtSfe0HKVbN4lo9TjasESAiHKymXANZy72yIDQE1Wqx6G9LJrpKNARVAr0J4/FOrc5NdW
 VXjX5uzsUWnZJxbvRSl25d5CXW9Rjt8=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1769611594;
 b=Jk4cYo/RQqzcOPZS+57+Q1tieRt3MPOVVhF/3uufP1mKysO8q40IH5W0K0EqA8s4srnWl
 SivcapPssTuKZBy8H9f57+/LGqUub1EbQR1iwat7LT4yWiAOdN90xIPAYMUJYxUYWmsN0d7
 t6uv9SNIzjnel401notVt9ncQ8bwjlA=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvOuh65b4Y/7gcLq233A8INH7bBDlSDeqP3pXMb1hKLhmtrNX4A4DOe63Nxotfq4cxT9tuh2BPBIOHQQVeeD7a+tZ/92a97jj/UcphA9mnBLHNqiGw2z9qlEDnOak+pV2AXfb6B8hvS7T2+W2eKhnMszdE4eH/D0pe5YdWfI6gPLRM83gLlRRhGbNE5yFwj7UYv73Z7lpVYbHlkbjwLOLuTtQPVcHLIeAwMwPKX6OTbHV+/TJWwU/kswuc0WdtnT9OFhDlV89ScuPvVmE4O9GPhIPk+fFXzakcRmT/6EAJFW4APfeD9agGFHAc3lHBrvInMCJykGWZ3tIijGQiB85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=hPi0PFe/jjsyDl+x296f6yoHYSLggdcg+refkxE030N1A+iamD3bMjDpvKn8XWl6XiG4D6sydtl+dz+EJrMBu7YaQUtniGzUm3NltxpBR/67kX4ayG+gXvpmVTiKADkslPPTX7aVlSDJj9bQJRy7OdeDBT3ENk0OH1mIaQRXWlFE33up6fzxd+tvtbc0seRT6aW5ml3g1Fo9Brl84dhvcERX7OBhcTHoGgRT2f3excvvYWog8ZYT9dUBxewpJ2hT2Sr8GHeMUTm7CimOew4T5gUG3y94FqH0GUDXrXoVpAEvY43rFlIyHuuq5/9iiycx7DuweaLK/ZL2gd/kVyq7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=F7BpFR0+xGwtuXYfGWoGdn3oGA3n2S3f30rv+u+cpIcQOJFAYyE/CFBqOvcjMrmxKl5IyRpMZxx6fRIIhEuhoQOWwEE6oh1pw2wAz6Kf7PPf+MwpjTEMEfTAjkM/22iEQ8QI2txoFF2C9ez7Kqh+vgmUWaZhXsVswQtlbRvNeD0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 14:46:26 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:46:26 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 28 Jan 2026 16:46:12 +0200
Subject: [PATCH v7 4/7] phy: can-transceiver: drop temporary helper getting
 optional mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-rz-sdio-mux-v7-4-92ebb6da0df8@solid-run.com>
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
	PAXPR04MB8749:EE_|VI1PR04MB10028:EE_|DB1PEPF000509F9:EE_|OSKPR04MB11319:EE_
X-MS-Office365-Filtering-Correlation-Id: 5573bf6c-ba36-489b-ec14-08de5e7c0892
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dnBjMXFURTZpWk5BWHJnVkpNdVdaNkJkaHh2bnhoTGw0YVlmbVBIVnNIei8x?=
 =?utf-8?B?NjRtSXpEUXBvZlJzTkFQcm1mM1J5Mkxad3huNFhya3BSVnJ2QlQ5eHEzeEN1?=
 =?utf-8?B?Um9rVEozWDRBZHJLQnRqRjY4blRwcElGZllLVWZOVUozTkcxUk1iZXlkZkE4?=
 =?utf-8?B?UEVyckRCTTJGZ1FNbzVQOFBBRkt3VS9IVHdmOFFDZEd3aU5KVC94bnhCTVY3?=
 =?utf-8?B?SWxJTWhqaU1GSGMzOEh3czcrY2E4ZWpRMkRmSDRaUVNkdmJiVUE1OVJRYzIy?=
 =?utf-8?B?VTlUVXc2ZXFjUVVVT3pCMllZZWJsMG0wUEV1L0RaVGFuYnVpams4c1JKU0J3?=
 =?utf-8?B?UUpUbkI2ZmlYSGsrd2F2ZGpNMjdrR2lMejVYb1RObmp2U2IwaVRuY0s4TmYv?=
 =?utf-8?B?aVprNXp1OWhMWGF6RlU4QmZXcHhNb3VZUjBPTWhpQUFyWTdOM2RmUzI1c05O?=
 =?utf-8?B?TTBGWkZEUEVvMGpJdk1KcXN5bzRFaUdad0hhV3F3bENQUGxMWjk2LytDV3da?=
 =?utf-8?B?d1FJRXo0Umw3Rm1ONWx2aGRIZ3FhYWhYMU55VUpsdVJQNnpvV3BXbGdVSitH?=
 =?utf-8?B?MUdjVTlMbXJvVkxMclpONEgrdHptVTBoaWVBdmNqbVZCeERyR2pXSWVZWWpT?=
 =?utf-8?B?TzJNNjNNenY2R1ZqR1kvTXZZTGJnb0doNTYwWmV5RzZiUVhhWkt5bWYxUFN6?=
 =?utf-8?B?WWx5cEsvR0FsblVqREtnMTB5ZG5GbjQvWmxxZzFjUm9QV3N5a0lxNVZCWVpY?=
 =?utf-8?B?WDkyVm9oUllRdGxlZHhFeGRUOEMwS3dGTmszUkZJY1hJVDg2SXpEQlhFL3Ja?=
 =?utf-8?B?M2g1OUVxUHVGMmJJYVR3R0V5NHpXaFlOV3dVdUFWNktPUkxWTUZselo0UWJS?=
 =?utf-8?B?MmE4QTdVVWJTREhtK3c4T28xSVZpMzZtTVFEc0s5RFNtcHBmOGhBbVhib0ZS?=
 =?utf-8?B?MkxwcS8zd3NVeWVEc24xNVBMcTBHTkFnK0s5MmtPbWcxVjFQdVJPbkQzem1Q?=
 =?utf-8?B?WFQ4c05oQ2V3cVRRUFJkM1dmOCtJWGdQc3F6SlR2Zi9hemRkckVlUkRCRE9Q?=
 =?utf-8?B?eUZRKzgzbVVKNnFJenVLWTE1QzJYQjhZdllhOVlWb3k2bmZDblBoTFNJMVhH?=
 =?utf-8?B?VkpyRmE4T1dyVXNiUEZKZm5USWJpdU9nME1YTGMzeWd5OC92ZUZyQlRGaGIv?=
 =?utf-8?B?YVVqN1BMWS9IODVaL2cvQ2Q5Q2R1bUxqUWplbUIydWdiamRJaEl5azNKWnRz?=
 =?utf-8?B?TkxldlBMdVdXSFBVcGZldjBOa1VtOG4rblQ0dkNTUUpXTzQyQm10Mm9Cd2Vn?=
 =?utf-8?B?YTFvSXp3cEZiTGNnV3NUaDZIc204UTJmWVZ3aE5pSDQvekRvd3FYeXlVRFNF?=
 =?utf-8?B?U1ExR1RvSkRLT3V3NHhjMnJtblNESk1BRkRvdzYwZjhOZVRtMWNBTDFnMlVJ?=
 =?utf-8?B?YUlxUGRoWGgwU0Vsb2s5d2QvL3c3L3ZBRkVwM2ZTS080aUpMWXNPcksvVnRy?=
 =?utf-8?B?dDI2eWpRVFEvcEcwZ1czNThldUZaa2hFMGViTDNMSmRXNnpNMWZJQmVxcnlx?=
 =?utf-8?B?WHJOM3ZQalhCbXB4djhXM3A1cERxV1dsdDFQNHBxR0JwZXN2TS9NbDZ5MkJO?=
 =?utf-8?B?blVoK1ZwM0hxM2llRzFxUEtQN3AvcVVHOTAvRFpLQUhmeWtOVmRRSENZd2Zq?=
 =?utf-8?B?cm5EVkVwcVZCbmpTc2YwVDdCWGNTR1VRa01uQkZCSzlNUUtka0pFd1l5dzh0?=
 =?utf-8?B?YmZMV0hYeEJHYUszOGE2QjdQSFRGekVWRlZjS3I0Q1U1WHkzZXVvRkcxRC9G?=
 =?utf-8?B?VFpsZHU5eGRVRWRYbVdpUU9aYVlZY3diRVE2b05LWFM0TnA2UHdBUy9KUk1v?=
 =?utf-8?B?NGQ5bGVManNTVWFwaXdMbDlHTkNuMHEzY2cxMHYvTTNHV09EdUlnK2czaTM3?=
 =?utf-8?B?NjdJZTRxOUpYUEcwU093Vjc5L1lvMGRkcmlGK3hKQm5laFNuaTAxM2JpVnc0?=
 =?utf-8?B?R2lLenRmVWNPU0lnVDZadDJJS0tLb3BubFVJY0xkTjRuc2U1RTFYWnFkQjlw?=
 =?utf-8?B?QWJmemd4WU9meEhZMlNxNW12a0ord2ZjT3FKSC9mVWNaMXBWZmxIRktua1Ft?=
 =?utf-8?B?UWxyQ2VJRG5KQUplNy9vSHo0SUsrdVAyZlN1bXFpVVJBbHdTdEdTcmJCTXZu?=
 =?utf-8?Q?MocYPFw5NUi/9DDBgMhEJiMlL0kTXggLlXpPhOnoTAA+?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: c60514b1c8db43f484a0964cf33e2081:solidrun,office365_emails,sent,inline:5c927907a0056d3547fa923b049e9e5f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7027a94c-3740-40ad-56d6-08de5e7c038d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|376014|7416014|82310400026|1800799024|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUVCOEhMQU5WYUExYmhqR3E1REFLVk1YejhPbzdNcitOdkVNUUlaNTJ0ZkZS?=
 =?utf-8?B?QkErcWRnRVgxa2V2Wm1tQ0V6Rlc5WWZpQkdkbWhqRm5pemJEMUwrNkFqdGxB?=
 =?utf-8?B?KzRrOVFwRGJ2QzhPOG53TUVZdzA0bURVNkZXUUgrT2tycktuSlRYRU1ZZXZF?=
 =?utf-8?B?MnV1MDkwK2U4Tjg1cllxb0pnRm1ZdmQzZitRb1ZodWRPR3JxQkh6Ry9GMEht?=
 =?utf-8?B?THpidkxzbStkbXF0MFhuUmRnTkladk5ieG5lbzR4eVR5dXZrbm5KaHZxeUkv?=
 =?utf-8?B?OTBWWlJnTStGR1lCUlFjWGRjbko0ZWNlTU4vcTFkVHNFU0M0N09nTWFBOUg0?=
 =?utf-8?B?SkMrWDZqUDhESUdQZGlDcVp2WGUzSFpHSGYxN0FVTjQ2WTZHOVIwMi8yaGJy?=
 =?utf-8?B?VW5jV0tia3FybGk4VTZ2cDNVU01YUFRIa1B1THIyNWV2Z1Y5bDBXNWZaV3VZ?=
 =?utf-8?B?enlLclJKYlBmTXd6WGNBcHFEZDhGc0V2RG00QjdVT01OMjlBVytBS3RtUmli?=
 =?utf-8?B?bjFxQ1JlWTBhc2hNcGdrYko4ZmhvUzBQWWZsbHNyNlduVEZoc3MreEMvYjRq?=
 =?utf-8?B?ZDMrWDl4bmVKWHBvVHkwcTlqTkpXdlRYcjl2bmdnSU9tVlNXWmhvcVVGbmtz?=
 =?utf-8?B?NDE4K042NmtmRjdwVzk5amNpT2EwbEZRaEhLU2FKTTFlb0RlSkxnL2lIajBj?=
 =?utf-8?B?d2xzMjUrb2k5VFh2WXRISHQ4SXdMdU84QkUwUFdSSUltT0x4WHBadms2anhk?=
 =?utf-8?B?TnNTQzB6UjcxQVYrVFpDMVVSR2lWTlhLN2xrVU1nUXZ2VEN3QTV0Z1BJWjdn?=
 =?utf-8?B?cytJWDE5SGNobEc5MkNYWEp6R05MaTNkb3ZIZUVISjkwNlZVKzJsWTc0WjR6?=
 =?utf-8?B?eFg2cVRib01RUCt6NEhYNUduQms3bE55WitsY3N0QXk4RWl1LytuNFE4T1kz?=
 =?utf-8?B?QlB0K2xia3U2TVFBWmlIc24rRS9CUGFPZkxYUFg5T2E3L3hheUVreFhvL3NI?=
 =?utf-8?B?TzVZMVZPV2pVZEdHaTIxWDJKWENMKzNEVTNicXRhcFRwSkU2aVZlOTV2dml6?=
 =?utf-8?B?K2FkU280VzdUNnM0c2IxU0IrS0VXQi8xRWxieGVOOXl0aWhCd3ozWm9neFpZ?=
 =?utf-8?B?dVdMY3djcUhVYTZzNkxqUnZuRTk1NkFFdWlWZURRY3ZlN0dibDBMYWxVUjFs?=
 =?utf-8?B?TE1NMmZkY3RkWTVmeG9qem9mcjllcWRwakZ1RGhzOFU4Wi90VU1xVnpRQWFv?=
 =?utf-8?B?Z1A2aXBHZmdLTjIwdndyeUswNnJqNjdkd000amhtV0I4S3NEV1JHbjBZcENE?=
 =?utf-8?B?S1BTMkVvU2FDUmluc0dvNWYwUDcxWWFzVjB6M3hKYUk0UDRlRUE1NURmT2VL?=
 =?utf-8?B?dEpKelJZeXNVbkJ6R1grRmg2eTgxbnpmS3N2bmdIVGdPWkdTYmJjbmxtRXRv?=
 =?utf-8?B?R2V4T092bTVjRFdQUnpoV3FGL0lneDFkZ0VuM3gvelpubHhDaFN5Z1JZYUow?=
 =?utf-8?B?OFJldFVidVBPRmdlaEk2eGpHMjBBWUJHcnAvMW42K2czTWt2R0o4bXViUmdO?=
 =?utf-8?B?NzJZWHYybENDNUxCdDJtUHE4RGNXNEtWZnQyRk9RZFpiTHcxeU0xd0V2SlRn?=
 =?utf-8?B?OGw4WUF3MFBnRitpbC9JYjNLZTEwSGZFTUFqcm1YL2gwNlVhdEp2ME53QXIv?=
 =?utf-8?B?M1V0YUY2bWxiaXdqSlc5VTU1OGFFdnkrUnliblFpV1ZsMGJrK1lOZisvbnR6?=
 =?utf-8?B?SGR1Y2ZVSXZWVFhMVldTUVp2OHhUWUlkQmtMWDc4K3psQ3lvckJuVmJiU0kv?=
 =?utf-8?B?Z0VSWWFYZDZEQ045QVRWTkFTSDNFYk5Fd0NuSnYyTG1rRlRDR2VFMTcxN1Yy?=
 =?utf-8?B?OVdnM3BzbzdvRkduMjdtTzFjblN6Ulh1MU9rYjc3N1R2WmxWMzZQQ2lQNE95?=
 =?utf-8?B?TTBQODNtaURhZ1M4VmhScksraFd3bllZbG90Z2FHcSs0aitaNHFaV1o4K2p4?=
 =?utf-8?B?U2paazNWZklFQURTeHRNUXdVdW1DZTA0T1pOMGF1RTJHNXM2a1h2N2pNdG4v?=
 =?utf-8?B?N3JQejNTQjdDcE04L1VMSTZCMVR5Um95RC83WUJWZkxPSU1sYkZSREZ6SnlV?=
 =?utf-8?B?MkIwWkNhcXZycy9aWWtGbFFWRTZCdVlOcHJPcCtjbnZYWFJLYytPSk9PTzhV?=
 =?utf-8?B?TUF4cWdPUlY4a01nditwYkJKMWN0aEo3a1krdDk2M3huRnFuemRtbUJYblBW?=
 =?utf-8?Q?7GaABflDUl37IUQDfDUFHGRTuuQd673ClfOnWWa18w=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(376014)(7416014)(82310400026)(1800799024)(14060799003)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:46:34.5579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5573bf6c-ba36-489b-ec14-08de5e7c0892
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11319
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
	TAGGED_FROM(0.00)[bounces-6343-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email];
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
X-Rspamd-Queue-Id: AC62FA32AE
X-Rspamd-Action: no action

Multiplexer subsystem has now added helpers for getting managed optional
mux-state.

Switch to the new devm_mux_state_get_optional helper.

This change is only compile-tested.

Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 81591d247128..2b52e47f247a 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -126,16 +126,6 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
-/* Temporary wrapper until the multiplexer subsystem supports optional muxes */
-static inline struct mux_state *
-temp_devm_mux_state_get_optional(struct device *dev, const char *mux_name)
-{
-	if (!of_property_present(dev->of_node, "mux-states"))
-		return NULL;
-
-	return devm_mux_state_get(dev, mux_name);
-}
-
 static struct phy *can_transceiver_phy_xlate(struct device *dev,
 					     const struct of_phandle_args *args)
 {
@@ -183,7 +173,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
 
-	mux_state = temp_devm_mux_state_get_optional(dev, NULL);
+	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0



