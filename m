Return-Path: <linux-can+bounces-6640-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD6DDcNJoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6640-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:25:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A28651A6766
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E15353103417
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD3331A68;
	Thu, 26 Feb 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="q8JCwEMq";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="q8JCwEMq"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022097.outbound.protection.outlook.com [52.101.66.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25A322B77;
	Thu, 26 Feb 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.97
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112108; cv=fail; b=t4OESr0Zn8a8E/M2PZBtgKp4SJ7KvCzcqS1WVbg7q8tvZvsxtB5Xuz8CzrH64LmgPMl683/rRY7wZK2YBHLRMzF1E9YGmZy4ZTUf5wR0K4r74Cxqm0xtB5WsLIRARJZg2C+kz9Amt2g4SU3/GVCJh+tehlQaPHoSEhAkYFBnE/g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112108; c=relaxed/simple;
	bh=jYQ1syx5r2WBhT07ohpkyhqnSMifMMTWAkOsCNa3X0Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W42oGIhpmWOt7fvLHBezHAGRBdsS96gWpF+IarSoPF1wAXY8BJFg4xgx0+NO3RjOONy3MCv1/UurU4OTJuKBKMBeDuVCRkor7AV42BLm72gupAbwI2objC8MStqMMxD2TYtsBM2j2ktR4BheMlHtU5m9/83sK/PF74vDxQi5XXg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=q8JCwEMq; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=q8JCwEMq; arc=fail smtp.client-ip=52.101.66.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q17yPRWE8+WgYwBet/7zgDQhDNSV7Q9NhNXZ5Fpakrnjq08R44xpODh2DJ7qz5O35Pa6QbPt9ULdHgfYDx2j/I0v13WEanVPWue8AmLjd97ApLOD5UeJmQvw1k1evJPrJnQIeFrpZ8rq6/Ok6VOUj49zqLz5PHvJJq0rn4li09Utd/GwCmEyADY7Cb2xpUgBp92V+7zSjutswbMBeqFdreHtOY3OO996iAp/ScWPwVXI3L2Ns5F2byiHZgixEbFAx6CNjt003aJ/X6AxBF0Nma+EpiqyFHtBB4TJOYwtaz87ZBDcHHeoRMyNTmFHsov2udqAyesWHtKMkJTIefV1Tw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75G/CfPQjsG3DlUp2fLUtPEYQ1QAhNdy3xV2UPRXowg=;
 b=vReqX4/shhrKuSkntkN8Out6os/d7i77RJQTcb7KPwGcdCZnrLBYaNY9563nv8YUN6vJNkI7yxO11aTUKL5kN993qN4nKPvg2McVz0p4w7eumJmyM0JIrcAbHRrt5Aua+23nE46vAc1L3LDzNCkklTpMC26PiHbl67yZxs2aFTCOlYEXQIOLvTZXbXeq8AkmkmUIapmZfW66iI3AdPgJkRt8orUBSB6FIUKO2szUdbo9LF2k6MsiofUqRoraunHGCMfDgewOi6YlEzVaonIjC9tIIKGwxBaTpQYBlUf6qvVUWOqhr476ASm+L7/rOL3RiHJ5iYvPP054OsG3TJ13OQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75G/CfPQjsG3DlUp2fLUtPEYQ1QAhNdy3xV2UPRXowg=;
 b=q8JCwEMqTpfejUhb8kf73HsafGVYtTdukV7hwltXjNarso1Z0gF9KSoROsfcMTQDI5IQfJ5U48fuh3OkTw2BJChA97fas0naM9GKgOHloNKtwYw9pjwMMRbPgE5gYurGSZRgxpPg1G61H2SG107wz/YaY+P48dnlf6TnqTt+O+A=
Received: from DU2PR04CA0248.eurprd04.prod.outlook.com (2603:10a6:10:28e::13)
 by PA1PR04MB10553.eurprd04.prod.outlook.com (2603:10a6:102:485::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:21:41 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::72) by DU2PR04CA0248.outlook.office365.com
 (2603:10a6:10:28e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 13:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:40 +0000
Received: from emails-6412129-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 8992D807C4;
	Thu, 26 Feb 2026 13:21:40 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:34 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NL9CQfDCwQOphquw5VWv7M0P+0C8JUSL0IczrO451pl4P3/bU+cGaxhM9t7hDDriusFlFp4QxToWH49ZBsWRL847FatSwuSTYG5MaRoM6Q37qzyLyCxHt9mnHdURVj3XpqgdtCf49yRdi/m/1YjjTmR5LEBV4EmkvevX0bmO0UuKxwCN4G6aNiFnZAWiDWwOLbAg2YNREOdk7AfaKmyeaaeE8gQUskG7I8oePlGKwdposD28KNanumaT48hZa/UAIwRBx6hW0fv3wnrqM9Vl96zq88Xf1OTp8hFYus+z+JCoGkRfQ71qT7sSu4MBQmUQG39cSKd9M0PwSqYbpRhUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75G/CfPQjsG3DlUp2fLUtPEYQ1QAhNdy3xV2UPRXowg=;
 b=vIwIp5OMefVwgT/aYHVQ5R721ZgWnPRTmHFmuOpXnLCmXqabPPydPjD5eMxPhxHOgu5MrzlC5YTrt1XalBN4IlFoRucOW3hHTGhTI0zA/V2soI1ORSqaVSVJo9p86Q/bnTE7Lru8hyNigHWC/4EExEO9fBQpMbLjYKO19HK8eKDG5eGitpmpOlag0KhO/E4Vl0UQEnggzUv1CTJMEWBvPkiFDyvTOJ2X3JJl2I90KM0h51F+mlE30M3tbMB/NjZMJ1eEQincYVGfurTXGYkEaG9PmD1bJV8iWUNP4LnZLCCjDtASYHmCPmG/vEUeYYR8zTKe8iBMqaXZw2osPirOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75G/CfPQjsG3DlUp2fLUtPEYQ1QAhNdy3xV2UPRXowg=;
 b=q8JCwEMqTpfejUhb8kf73HsafGVYtTdukV7hwltXjNarso1Z0gF9KSoROsfcMTQDI5IQfJ5U48fuh3OkTw2BJChA97fas0naM9GKgOHloNKtwYw9pjwMMRbPgE5gYurGSZRgxpPg1G61H2SG107wz/YaY+P48dnlf6TnqTt+O+A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by GV1PR04MB10521.eurprd04.prod.outlook.com (2603:10a6:150:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:21:31 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:31 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 26 Feb 2026 15:21:12 +0200
Subject: [PATCH v11 4/9] phy: can-transceiver: drop temporary helper
 getting optional mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-rz-sdio-mux-v11-4-c2a350f9bbd3@solid-run.com>
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
In-Reply-To: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
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
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR04MB8747:EE_|GV1PR04MB10521:EE_|DU2PEPF00028D0F:EE_|PA1PR04MB10553:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e112c3-8639-455f-209b-08de7539fa70
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 pVOvDcYiNutW8AKRXzu1B72qYhvNvdAnrs6BXwoMrMHWKgG6jU+IKMXOQsaQ5wD/thnbgAmCWMvH5C/AUAl9+8yOAAfzMz1NrICiNUe8vWePKAWaM1cnKV3OAGzeh/Ydv3RSKpe53GFjgyKkNEROyI9Rmb/gbnUcqTSfiBnWClBOvzsYaq7pDwvgeSAZKoNKzoElSf3qdfye2TtU/cHuJbx2LsU4iDYLBuVaeLyN6Nzp8JjqmVBJ/wcdH4fX42WjMmmvvyyZiEp1qmOJDOlQv+EWseoLKyM2O66ZdDlOecdVu80HGqgjtZzfU9d3cFPAGMLuTwk0Dszg60vxFW3f+NOcL2LuiNoXyYxwRORD0IBikiVve0ev5LbhJyFeuvr+PzYnTG+izVxso3N+Yd87AdyI4J5KsbXKdC22UTNIyc0mcJ3sTdr1hq1VlcbceficHWJiDkeXd5fnxEIBwkZeSmuhhR/2Uvy7ii0UZR+HnFrL5ntEJ2CwtCPJA5pDraRIbMcb9AesgD2zEKAIN+K6nutEsjKb5VXT7YzSrNu1e4fc9w8nV4bwKMBAdZcs6WLUNT3r3OoCO/NxHyxGejCXIsZ7G+H1wnJxi9cNiEVbpVb+qzX1KlV/zrZA0O4QEGAcY5fvW3frM9yo+GFU3HMSLlr0lgPduq0DzxzH/qIvnNa3mFFRiTLlUF2BVI9IUiyzHaDs85Shcx1yRhbjnUgo3LHOJrPmH8IY6FKPsfnx6OihobKedNtzqU+F/oHtFFm80mLmnMtYVQHrQcZ3a0VVaUYVoHH4pS1bhVom2oeuVE7LdK50gyJmjc7pMSqwifyo
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10521
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 50340675401540bda9e1ba056d4e9e42:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5d99e3b8-3cd5-4871-9c9b-08de7539f4e2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|14060799003|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	xoPI9g8ZSSSwefSvhutrIeIb94fZrXRXQPxZuYAKyAr7kyzkie10DzHxgsHdrmVqb/ZJgnB+74TFewI4yy7xas4K8uwVpEiDuHSKrSti+anncVzKHPZaxAtZlRAJP2S4BojUgor8G9Jcolwq7ugY9zy/raPbBIA4/8NlI4nssE7zihUxpyGrFIaUiIWCMdz3lRhIVQmafJqqoBH0nVRpqDZfXF8Dj/WmfZ941nP5gunLj1VezfE2/aDt6MreW0qS6AgN7SGRkba71oPtXZiKihakTvgJu/lRRyorSU4zPd2IINTTke/xt3nZl8STW3wOpoEkBUfDSIXLt3kStMfM4aJf7WEjqu0h/WXd1Obddxs/CWbcXh93vWc3Zo/VTtUDhFdbqtkpc1B0I0aUycZYG13gW+pHHDMi0D04cRZE7xEJsTlpKH6nq1HY2//tD5Jv8vTVYG7rPLorwoEl+K1La6+11rDks3CO4/Y10dEFeJkqJJrvIXUdqD+IPUKlRqC6X2I16/2YyOd3A46yXPNqtAHBJFemeJ2ddqRqF8he6gvL233xuEZ/fgrAkA21SqMWgD0joRINlmdIQcjgADdLMV4Af4EurNPTXiQIZ1LWNIQfkYBOka3PQNULGtNVthCRCKIOFVgBFdslGx8A7a3qS1c5E8BevORR/mO07GJxUtNFGt7maj9SS16AnyDQpeOie1HOU61Ybk6DeQiwPUHKHgbyTmuddCQuqNgd1AY6cQ8smTmtqZMyF74hipl94VNwrIuCAMXvtm/LJjlHrTJL+QXExhRQ+BG/dV3v/pIjbD37FUQUMAWeoWKqowSN2a1UAi7QmjZDq6CFIo0mwq0aokZ1og1at6l0aIW9FNYFcMk=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(14060799003)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3GcOXjvjrnY4p8owUzgb0gdN/7ASxB7NLCvwzxAN8SWoyrqR5JwTnj494LzlcwaO095HSYQqR6OFy+74uO3ok3xlZGwbCk2BtaoaqyZrwDL3HWuNVIZO9Key20TnHQwuXBfbhuTykfRd9Gpuoot3PBT5HyhxYQvDyQ0jcSNbjdxcutyWKT96hoqjkr+xdUkjhrZ4PhWcRWab6ViyN79NsHx5zi5kVpt2gaJArWPBfE4h2mVMEAPcVG5/g1+xqMoYv65DJ/ibhYHxyK3o2MqTj0DCHAGeZYcO+/S959mIiGVtIoY8Nj34eOf8AVrjSMu43/OzHkxWEgoT+icQQHJQRTRVpY7iF09ISb2MwsYQzIGLAPCLj4YpDXTrqRsCqJbK5jMTnK0eXe0tCy1OsHyGwF1rijSYjV8wi4B8Vy8WA6drZCYYpIAXqij5JDZfLFr+
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:40.7963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e112c3-8639-455f-209b-08de7539fa70
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10553
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6640-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email,glider.be:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A28651A6766
X-Rspamd-Action: no action

Multiplexer subsystem has now added helpers for getting managed optional
mux-state.

Switch to the new devm_mux_state_get_optional helper.

This change is only compile-tested.

Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index fcbca9d2bded..2b52e47f247a 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -126,16 +126,6 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
-/* Temporary wrapper until the multiplexer subsystem supports optional muxes */
-static inline struct mux_state *
-can_transceiver_phy_mux_state_get_optional(struct device *dev, const char *mux_name)
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
 
-	mux_state = can_transceiver_phy_mux_state_get_optional(dev, NULL);
+	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0


