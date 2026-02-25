Return-Path: <linux-can+bounces-6629-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIElJTDfnmkTXgQAu9opvQ
	(envelope-from <linux-can+bounces-6629-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:38:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDA51969EA
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AEBD304FB4A
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F7639C658;
	Wed, 25 Feb 2026 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="JubgvtEO";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="JubgvtEO"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020085.outbound.protection.outlook.com [52.101.69.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1514395D93;
	Wed, 25 Feb 2026 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.85
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019317; cv=fail; b=LsfOS3VrgQxdnM6BDnw85uZW05KTs7hBjVTchfr520eR4pL28ewZ2F3+uXQO9fqv0CmFN8XjYVElDDaqLraIjwdVaPIbFYO9WQenWQ+mR3M5CjNYA7OqEeWWrJhEa2qfrjm83o9HonAV5L3V1KmryqPgWzeaHTO9OUjnkCzlX0o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019317; c=relaxed/simple;
	bh=y/GNtmWP7acS7RvvI1tniqZBi6eMdSa1hTUwqx1PoPY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sVhmitpvrAfSobjbRFr7H9l1NZiyjzXE9eUASCycqT5eQRNVjcpBeH6G5QzkINw/4QmdZMm5VIa9DW7PDZh/mP6vH4es/Zg7+Qtr/6A3FPYfWPToRMd7foq6FGfoOU2GJK/tUocqZ+YboB4gUB7SJWly8lnJV8VsieiZgdtHHkw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=JubgvtEO; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=JubgvtEO; arc=fail smtp.client-ip=52.101.69.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kGIus/F3dXdrCe6a88yxSTyXZvh//qUsaTq5KV1IvLctDk8Gf1sdYJiGHCQQGmBWq/ZCkrsORF9xmKu8y7gVUKdBglnmp1G+mk0lCz9eISlv4TnJ/psHuxepvECUIWy3V6QU8ESWB2l7oONL+W6X6zOxFJNCFNcPs5FLFUFNrA598z0Oex3YKGnAzjzMzko9w9+EXRl9DmNpWrPqubmH5ozGE1QzCv2vUmw4fmunjCvPHd4nq+PdFn0C3DkYZkIRTegr7anVv7n2SsYxJb4nHCpJv1NPTpqDWvkjCSpPk3KELc2Mh7Gnu4tuWQ7UyDMw2F7TPRxbzd8zDsN0jwKb3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLIKsliEswjaPXbuicMEHAX/h82aBprjjx1Bq7A/fXk=;
 b=Mh4CQufNrhow9MwrJMHW9/yp2JEvFGlst27sFg78EjE61t+e6gIHwFacxoB21SKJlW+Yqs2IVXXHMFYa9guA36RGLnqKleWQ3No+YjNu4sKJLwVQGAjPF57WNGTuGG9r05D4PnANz8nVRnMhinjUX6uIcJearFmmae0iykd95HsCpiAL8+CaE7i7iiy+mbZ6jyBYMp1t7STpiz0/U+3oEtQ3M9kxQSLkzO47By5Hn9W9ZNC87rgKfQLmiDZMqk3TisrzU34wI4lMjBLqRR3W70PIvOkFMATs730Jz/zvsDt3zEM7bUa1gD01pzhJXxkVz6rQeyoiq5/4iwn/q9nSTw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLIKsliEswjaPXbuicMEHAX/h82aBprjjx1Bq7A/fXk=;
 b=JubgvtEOIqNS0OBYkGuMxeU93bwG5T6S+IDaVVHElcLcuUd0fTlgumOAYU+JfPyWIWzJMcONyB4nuwFGHLvhbJl5R5aALcX1++6Fsr6XDsbD8rg/lOrGg9lIVZK5GJwADg9KQHBpFGR7VFypnWEkWmuiaA91pp2pCFeIXVcMPdY=
Received: from CWLP123CA0098.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5f::14)
 by PAXPR04MB8490.eurprd04.prod.outlook.com (2603:10a6:102:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 25 Feb
 2026 11:35:07 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:401:5f:cafe::ac) by CWLP123CA0098.outlook.office365.com
 (2603:10a6:401:5f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 11:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 11:35:01 +0000
Received: from emails-549506-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-66.eu-west-1.compute.internal [10.20.5.66])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 4675F805BB;
	Wed, 25 Feb 2026 11:35:01 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:52 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSob57uBfVcA5MGN3tbSiEl10bsJnICaPjNnUj+u8MgGwVPaR4GGCHgk43ebgUcPZ6XN4s4Ux8Wkr48+p0DuimEBaDs5mD52CKUBHo5RrerWVvtVaeHLtJn5UO0VQrR4S4sBDUfqiolrRWUdw1buZjhwH75UqdVNw7kBRoAMq9Tpl4Tr4QvRYRp2vw97d1cDVUiBvmA8+Nunvyq8bWSsFV2hWlcrqwdwWcbEjRD9+HWCKv8JKPSUVOcJZVjhYTpkVpvet6lASRoOYXYq/MYfoIvGtO4Hebc2ewgo8mnfBnheDDv1qRwyF3s4UhxzEdeLZGlf85h4FCnNaFWTEu3INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLIKsliEswjaPXbuicMEHAX/h82aBprjjx1Bq7A/fXk=;
 b=PlzZCAjdBERnJX63Y46FSnF5VD7zkgW5omOYXYEX4ryo79Z62NYRxmv+hPRW3iuURTkRSHlhRteTtIl9x3DqFkKrML4UqMxu+Y4uXweaJpPTRLzzhvNf5+kszAVlgl9+ls05jjaIF/6qX6iNPm6d3yi6MkOqBAXx6yJXQIecAkl21r1k8x7VRlG/yfQGnZuTviv6Jw5QdRsXLiahxDt2hEyvtkHR2EQBpnb3Cyj2iQyuPwbyJZ+WH+S+rFWLJs/jVP3cYLeQHGVe/S6uGDjTLg6uxrYQN7sd8eWAsx6tymNsa6sBovCAGsJEUwlyl8W6m5SXqUb1zqF2vcQq/lr9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLIKsliEswjaPXbuicMEHAX/h82aBprjjx1Bq7A/fXk=;
 b=JubgvtEOIqNS0OBYkGuMxeU93bwG5T6S+IDaVVHElcLcuUd0fTlgumOAYU+JfPyWIWzJMcONyB4nuwFGHLvhbJl5R5aALcX1++6Fsr6XDsbD8rg/lOrGg9lIVZK5GJwADg9KQHBpFGR7VFypnWEkWmuiaA91pp2pCFeIXVcMPdY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 11:34:49 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:49 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 25 Feb 2026 13:34:23 +0200
Subject: [PATCH v10 9/9] mmc: host: renesas_sdhi_core: support selecting an
 optional mux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-rz-sdio-mux-v10-9-1ee44f2ea112@solid-run.com>
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM8PR04MB7827:EE_|AM2PEPF0001C717:EE_|PAXPR04MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 992ab04c-1c1f-4528-cf02-08de7461e9cc
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 tJZXaBob87NVZmBomP7BR2M2uImIJoW2X7h+xift+vAq1XLpUKEXtCnpglvhO8TUy0EbMiJHi7U0/kF+OhEC4NJOCuhPv0NCDn9R2HUOAg6aIB1O6bV1D2ZgsEniS0bHyTC0PTk0RUHPnF/4Z+SjwN+fiTPXgBasGIaXUQXg7ABD/nkSnwfdXI3CretMQpJ35ygtgXaYeVevmPQuTtSOvD9s8QwOyKvKXdlUeB/VkSF3WFxo0CWjkBnRArEiP70aWQ84uvpXdX73SzQM/lS6AcEaUpAdl2zwevvr3MtE9aQbKGH9IxqbDYYjLT+SNDkH33LrHGxMxU3qmpSc57GaHc8KrUltTGnCXanxZvaWkj/gnVA7KVU5BO6vRkwjLjQHrNkNbIp24w2z7S0b7sAMrWE70KLM4RxravQe99MhktbkaQ3Y2eLqSwPjSRNPxHPwboIdV5xp57GoUHhKX2nWtKw9x60GNCBgbvNF/6LOS9dd8xFu/VMvGncovlnMM/FyBQo0yP/9OlhPFVN6Meyn+GmdPOHAB6Wi29K+C8sxPtqsBxCmkiT4/vn1KTSr3iAW6uCZJGVRrtuFJe7y/cDfi8FZhplI4qT9IVoc+OKY6/HFyb0wW7W1cgJiHSzt2tg8gEwvV4bL1Zk5X/ss9lXW1S1NUka5u23Gz4Y5kRwUkqluFr9ZfmELnS+36MaFlhV55QE+yjy4CfOkxjDRlZkKKCMUzN+1wdikFCBvkcXJB6xp2oNUjCpXo3gC2z3f/90sNGcSW17YpRJHmmMTTeWB9Od4JEuGV/8jkawbEqTWGr1o3zUfmqRLTZvJ4zT9hGHs
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 16eef51c97e9406d908ff8b7e22fd110:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ecfb2888-33d1-47e7-e3ea-08de7461e296
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|35042699022|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	8kAmf7erB05MN2ZsTNxCnSHPDKq+EtVotOrp76DSgUanPyMEfXcyVkljvz/jFxA5DIMP3VTeeigzeLIlViQU9dc0GQsJrMiNKd3U733eFJK2SEeTN4VSi0gBNKVpu4b2tmCDaQdcjEeOSNGYLrdZpJVQx9jVHRx0sWHJC9TwaVNTp6q8P9o/+DaHLLZ3UwAzcVlju2WTD4xo1b5023lofQzmtYdAD3ZzNt8W5CjKUzsz24H1i1msqLOZ1sfZNepkH54VA8SXyLm+FX17VH4p6MhjbhQFxm77vV3nE6vhgCKVUy/D3IGulLFK2UJsCUAkkoPgFc9OS//BZMcg+8MqGMr8fyU5a8oJ2OKpg4nt8LXn/NINqMLjjIGGef5+L2psqjomchsYcW/aI5P1tgeM06859uJmjZ/H/tUw2ydjNzEiejPajT0M0YBbb18vNznU4yzQRgH3QQ6+C8fHcgp5q25hOjo5T6K7xEi0PZilgnqRvrX2X6cYqw/345faKOfUypKUL3HveY8q91nVOL6aK4W1V9et2RPc0SfixQc17Js8WJkGnQBU6cKdcUKmM1VFt1HBn8qTszNr46BYwlFDmzGuilPU2/ypmq0XR8/E5o+w0WZqhe7tXFInQOTdHbimyM0jbcRswhv4RjhL0smyR6Dp7pcbdplOKk2Jb01KZg9gi8vTp2RzkSIK3ynInOQRGuS8A0dHShHXwC31ejYYt0D1H6nUIeDGn5Ggpsm0KRTW1aSUu5kwPGhh46NZkIKc6Q7bbgCUxBoSo/o//uuKUlk4DhsfvtzzoTFVNYZuCweWAJqo/StHebX4v0RDmY+7RNM1/2BY8UryBUO1JhL4F8WukkCBcXz6Dwt19ZM69as=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(35042699022)(14060799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VfhasNDQAgIwgqY50ibNkAc0BOmyhef87k7ByFqZsFSSpfVBYiQpYqNFu41y4E+1cVgvaNJPzzv2YQvVH/ClXgJzsXCo2s4sA/DcPSSW4mL7jato5AD27i1q2oyFyS3MktA2QRXMK4ALv7KKi1qTVAI0ZdRbGMO0LDqTYrIHI8Epe6DoOMaPi/Z88fO5SlwXJzQ6IY9yfhi34HrRZN26pN36Vaco2joBzb3N0wK7iWeDHCOI5iuJHUEfo8s8u1IymDkHYZImqhUJeLhl0nEd7kXLDRXsUFyw9j9aKfeQQz322sbI7m2hDt1PUFF0uQ6AUgT3KAYSB7YQWiESYLARkru2VRKr+JxKH6UwBZCpiwWsnrTEPXbER44Nv2GfBvICxsHECniBCsJBFqRS+Wqt5hUozu0pfR2JB0FYgssTDT5SxbbFXjXup1ZLl586uUSE
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:35:01.5357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992ab04c-1c1f-4528-cf02-08de7461e9cc
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8490
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6629-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,gmail.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3FDA51969EA
X-Rspamd-Action: no action

Some hardware designs route data or control signals through a mux to
support multiple devices on a single sdhi controller.

In particular SolidRun RZ/G2L/G2LC/V2L System on Module use a mux for
switching between soldered eMMC and an optional microSD on a carrier
board, e.g. for development or provisioning.

SD/SDIO/eMMC are not well suited for runtime switching between different
cards, however boot-time selection is possible and useful - in
particular considering dt overlays.

Add support for an optional SD/SDIO/eMMC mux defined in dt, and select
it during probe.

Similar functionality already exists in other places, e.g. i2c-omap.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/Kconfig             | 1 +
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6d79cc9a79e2..40046981d240 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -705,6 +705,7 @@ config MMC_TMIO_CORE
 
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
+	depends on MULTIPLEXER || !MULTIPLEXER
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	depends on (RESET_CONTROLLER && REGULATOR) || !OF
 	select MMC_TMIO_CORE
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 2a310a145785..f9ec78d699f4 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -26,6 +26,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
+#include <linux/mux/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/platform_data/tmio.h>
@@ -1062,6 +1063,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	struct regulator_dev *rdev;
 	struct renesas_sdhi_dma *dma_priv;
 	struct device *dev = &pdev->dev;
+	struct mux_state *mux_state;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
 	int num_irqs, irq, ret, i;
@@ -1116,6 +1118,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 						"state_uhs");
 	}
 
+	mux_state = devm_mux_state_get_optional_selected(&pdev->dev, NULL);
+	if (IS_ERR(mux_state))
+		return PTR_ERR(mux_state);
+
 	host = tmio_mmc_host_alloc(pdev, mmc_data);
 	if (IS_ERR(host))
 		return PTR_ERR(host);

-- 
2.43.0


