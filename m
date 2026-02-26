Return-Path: <linux-can+bounces-6638-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBaoOXtJoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6638-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:24:11 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF111A66AC
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2BF230DD222
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7832B9B4;
	Thu, 26 Feb 2026 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="anUtw969";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="anUtw969"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021111.outbound.protection.outlook.com [52.101.65.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F813242BC;
	Thu, 26 Feb 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.111
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112101; cv=fail; b=MIm+NW0Ja16/li1sOGi5w0o3mku4r5wTkd1cIHN78xch5etbAehZZ4YqKb37XVVlnjBxH87hEvTk9rNlrGKPmLrZcLBvtlgDxUGJb3NkBhS4pIYINGyfIYhhJtAapdHBrNyzKuw/Wjmb2pVVGoXLx6dEJQrGvInP1mEE3ne8+3c=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112101; c=relaxed/simple;
	bh=vbbBOdQUjTNxLK15Ec4u8vqpFcFMesnsAjpqirLglxc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GO4qLv648GmpRD9zjFnRGESVdNHIzKnVq4mZHjil4d/Hpf1UUzg1WQloYI5jJnUouYACFkDgJKiRz9OnE0D9BwvG+5X2DoC9XoFzJuP77s/1Rxxb5wwivccWwv12XjjLe6qsA5SsZlXuOYK+h7w4J1vdhcwYVGkAiTU2z93lpP0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=anUtw969; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=anUtw969; arc=fail smtp.client-ip=52.101.65.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IHQesF+KOyVcuWyPlQU8IxETFyix86IMrRshPHC9N/l+ZkPXG6cCZARX0PlHTPLsUcMbyngkkFB5Z6o0TQdJi0FDxeNv/8foebMfDQpRd8M6Yu+TRPHR7t7XPCKVz5wa3iqJvLQTuuX8Ka7Bjfqek/49h2GlP2bFF/tVwf/yPcBrUSKPnBx/PWlne2XcufqBvUx5bmjgAsJvEy8ur1WyipET2T8I/9dQ4RAqQjDYv6mSxPjhqJ0n96oLtxwhGfpQeQx5pt1qMM3hlO79Q00qB9C2FSKWqVi1RgfM2QllYA72MrZf9Ns+shBGWi5SjziDrMVpu9Flkak/Vm1mQVPhzg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKF7I9zOLyZw1miNJ21IT8te9ajBviLlwLCKyU3RJiw=;
 b=bj13Owax+sDbFlyGbC8Ng1oW9OZcvBzp1yK9u4fMD8Hl1HbzQtZJM41yDMQGaNeSJ265tIuWL2c+cjELPgWTvsRt6IK+48+4YxV/DAQ2f0UL0s9DcwClXb4masXX+W4unbNjG1+IoRL/LRay1u34fwONJV4XaxBRPH6QWW6MpjSWsOW/Rb2697uYC7rr1ujRQKBG5VfAPwfw43J0TwL7Lk8S9d7xOwu4DcoNEHLAHBXMkPPfIM5HHN2qOF9aeI7c3K0FyiIdx3eSAQ/Zmd7hOxiHK7EAHDF/Y75kPgyO/yq6Ds4lDnbrAf/CVAy5bGrVqmTNQHINqmZGcDrF/QgGPA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKF7I9zOLyZw1miNJ21IT8te9ajBviLlwLCKyU3RJiw=;
 b=anUtw969MR8o7IQ+K7QWMvr84fisodSwBEqxq/D7lWVdIyylsTxQRBrUcbbpDqa2Zd+nUxl2yTHp/tEUu62+oU/jnM+fkuq7SK9gYMTIkHFYEMmz36N7cy6312Aj+4SJauOM9WWUwb9za474gq4jlotxuATKlCBoEhcRI6jy378=
Received: from AS4PR09CA0009.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::12)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:21:33 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::a6) by AS4PR09CA0009.outlook.office365.com
 (2603:10a6:20b:5e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:33 +0000
Received: from emails-477974-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E27C88014E;
	Thu, 26 Feb 2026 13:21:32 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:27 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei2fusGOe0MJdwoeswEaIwaFaDLR3FWhfeTFxrxzruHjtPS7s1iVi8kgFILq8VPpyw3Q0vDeBFl3wpiYtMG3HqLhMaHncobUuqUiKjtZAxCTHVroQ7DT8cy5xbv/4gWas1MZfwUMcJYL0Ibb8NSw+FOtolvpBVT8uJBzWzQG+D/mVS80ZFU4i7Erp/Q4gn76PmjD8p4s81OZxZCtCYgx9b5QcVJc2Asgu0+7+6Azu1xoMEzLGwwWRCUhTGw9A6GNWoPRlT7+fA8NPZ9hGWC7agx8YDxI/bAWHhICkxZ+gngndzJHjB+Kk/qBLyp/SGBeNiGgjsoFumpt3Rw8UfBVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKF7I9zOLyZw1miNJ21IT8te9ajBviLlwLCKyU3RJiw=;
 b=mGmnLkvmlEWqtwawq/YXM3j4If6JMGd8dc3zyh5CO8KwBUkPDC2zARj2gFMASdbZ5AKFZndoQMrjnTxAiuBcD4Q/WpXg/xHvxBiQNJf6VtM5gQQkfLAEZ1bTUkydeG/UgId/Y3NVtRWWvu/XG2xFtYLpTV8eK/8h1iQbI4aBhJ6bj7amb6UPps3QkfsoP/EyNz5DH8PhtO6klCXOrvwuO+TJOceWLw8xYFPsr5qwBvyKu8MhnCs5O3baapNbyHzR9vdfqR5GKtrM5y5IgY5RmiNre+BUaKvFqxG3iOex1mi2tgpR/vbZhBshd82RS0FG5zSw60G2aeGigDNjyEbOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKF7I9zOLyZw1miNJ21IT8te9ajBviLlwLCKyU3RJiw=;
 b=anUtw969MR8o7IQ+K7QWMvr84fisodSwBEqxq/D7lWVdIyylsTxQRBrUcbbpDqa2Zd+nUxl2yTHp/tEUu62+oU/jnM+fkuq7SK9gYMTIkHFYEMmz36N7cy6312Aj+4SJauOM9WWUwb9za474gq4jlotxuATKlCBoEhcRI6jy378=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 13:21:25 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:25 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 26 Feb 2026 15:21:10 +0200
Subject: [PATCH v11 2/9] phy: renesas: rcar-gen3-usb2: rename local mux
 helper to avoid conflict
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-rz-sdio-mux-v11-2-c2a350f9bbd3@solid-run.com>
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
	AM9PR04MB8747:EE_|AM0PR04MB6786:EE_|AMS0EPF000001B5:EE_|PA4PR04MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c791a6-c556-4678-a2aa-08de7539f5ef
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 CQBolabPeVSQ3zj5LWsBtn5bML1pLQDc9NX/GsSY4c6ymWcCZCbBZK6/ve77RD9sehmJm/9duCfLOp6mHRQc2sXYM+E1NbqCayzblbASKV3nGKrclZp0S8LsK1MCjAZeUYbI1xKGsEq6Ao/+1sQi10cmq4nEtWffVm2Gkf31JD2rTUffTFVdK8gtn0xLBWAJ53334nlgaTGHaYHuUjJqGtT3gHxqph3hPgEKRx0X/KzSwcSOid42ElGHB99pygiiaFU1UB2QRgJN37bAseHYfluVLh9qy5MjXackVq1Lswttua8Z75RfU2bB2W76CUX3soTzKJL+yPlaGU/0xG9INL80fDlwHbaLq3c4tTuMVz4cpqPMPEr4ScJXqgMCMM7Bop0bEoJqRVzZYW/22x4wZBGqXkfjRIyTbajv9/5PJR+F1DtjzVJ8JDqEhg88yp7u76bRVGUHgug040WshdNQsNu0mOFuhWllfzmtQSiWi+D2/BX9pyxVMRopvJy/NksgpwFn15ZrLrcJi8h6EY3RREoUVMjf10wNuRjTgQJkpLDU6sl+RF0OgyhT8hFiLGYtIl+yizV9doinqKHCt9CgJwJ13VH0ogoNcSi3e6lS+rtLz1U+4zxGZWuVgXXVKf6++OdgKsaxgtir7u4xJh7dbgNokT2R13rW38ube0Jp7XmYBYYLt1D+J57ZkWG7vmJdQq6wHhdwj1JdEZBsWZKtybPK6IBFuFlFdyIX9ad1Xou9MdK//RtiKSwlaQrWEMI6g3ig4xcSIszZv6gs5R1QP+YwmwFHytWsgCo+Rav+XV1Z79P/FIJTFoWWmaz/B2H5
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 85b325692c6c4057af2071ec8481c8a6:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0c210ddf-ed96-4324-4f2c-08de7539f15f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|35042699022|82310400026|36860700013|1800799024|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	Xn5EUlmfCdZlU23M7kigCm0GNUEeSqcf5uyUI5HzxJClQ/J0+xiyuk1IhwQNicwyuXEzsaKVwbI/ks8hR6qOeaiWK9GAYYWhkexk/ma0PeGIlYm/PByeTT1ZAIbqrQQ9XIuZhikhl01hL4CkRDnkprSpPTN4yACE2w7GuoEu0z8rqTHgZxGld7ijdaFPwIHCGzyk73Uu9qRAz3Vk7Z/TqXElLKCQbPBvQn+LxlgmTXuxyYK/yOk0tXx71Qyd4uXGbpOv97rCdkoX/yxadpEkRnY8oIlDM1VJfTGOcXbU/C9wEp/z22eJMgO1NNYWdxIWwQXte44WbK4UPvoJjW88fNrQKuM/VojU4xMxAvVKuGM3B8k3VG+jmz9R6cV1IYh7qOLq/8+jtjw4pd9IJzI/Fq/PmCJKiyXqQeQOb6CKUIqfnLll2qzBuIrlcM82riQna43k+yxl0EjQLFemMpP8K0Pt30Ff9eGaWuWl4go6L+BFLJTshgbV+cSi9IaBOqV55LFz1DF+iowIBMJEf2PdAuLPAxDs2NLyT/FVqam6rmj1a6sHiuChc1wlOnEIs5+6MfL5brSA1iMPvtrPxa6Pw4XnN17J+oSgwjY9RaRBuuHYSEMw1337FDIQ+4dGNE5Auk6QV28NUB/19+DpSfcEHD2R2gGzRdn77b5mYM/QHmdMS3EoyjM3DMgk1QJBvGcD7FV7svCYuphu3yPSHkS6KDdkL/KV6u0ei1zhuHmk3umrlT1N8dH/GqBtJriNXePtN+TrmQhsPJVS1D2BDy9z+CPKthpeUFDqTddAp3dnvp1LuBNC8CnUkTSAwsqp5V/SGvVxfFQUr0fW1xq6W+DfBtNNkyXQchOWxBwdLZNF4aM=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(35042699022)(82310400026)(36860700013)(1800799024)(14060799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8cexRoQtC9uBlWNFYWGAoby7magBCwRZmQIetU88yf9gA6DXKfbCrruwBig9cbhCBn7GBzEsIAWxfGBQEhjfbw6Z3xnTe70bEDfvsWzNVVbd/fBw42NL9LmccaGuRyLL5SB6GQqXa4vbFwjBbrDkUK8sP2qhGTsFB+0z8b0IQZUvd3tbNRAixKh5vD5fkMVXczjJLQ9oBi8HCpqSPVdWTlM1htevJPP/1bT6H1wv3l2oJc7m+o9MmkxYCjsog7J7YEpjRgDhEiRF9uNy/m4s6TRbkR9l+uPNk0IJ4ZIfCdgeyoNAl1BlThRecxQTEAtfGPFlXi6vZhvX+VdykMNdJSqgTsEJbPXexniOpXVLTSJsSFpVk7bflqdc1o2qianZVR0CIbWT1V/snHD18+xOdAvmHt34RnZ1gQlE+1MsiyObL2goqR0S2n+PJ+GXa3by
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:33.1875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c791a6-c556-4678-a2aa-08de7539f5ef
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6638-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9FF111A66AC
X-Rspamd-Action: no action

Rename the temporary devm_mux_state_get_optional function to avoid
conflict with upcoming implementation in multiplexer subsystem.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index cfc2a8d9028d..1155b111420a 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -941,7 +941,7 @@ static int rcar_gen3_phy_usb2_vbus_regulator_register(struct rcar_gen3_chan *cha
 
 /* Temporary wrapper until the multiplexer subsystem supports optional muxes */
 static inline struct mux_state *
-devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+rcar_gen3_phy_mux_state_get_optional(struct device *dev, const char *mux_name)
 {
 	if (!of_property_present(dev->of_node, "mux-states"))
 		return NULL;
@@ -1036,7 +1036,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		phy_set_drvdata(channel->rphys[i].phy, &channel->rphys[i]);
 	}
 
-	mux_state = devm_mux_state_get_optional(dev, NULL);
+	mux_state = rcar_gen3_phy_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 	if (mux_state) {

-- 
2.43.0


