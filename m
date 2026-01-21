Return-Path: <linux-can+bounces-6245-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIC1HN+dcGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6245-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:35:27 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7AA547CE
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C533C42C57C
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861147F2C9;
	Wed, 21 Jan 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KjFrGoRX";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KjFrGoRX"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023076.outbound.protection.outlook.com [52.101.72.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50015478E42;
	Wed, 21 Jan 2026 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.76
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987289; cv=fail; b=F4RCgKkAUrKcjkdoUS9O/BlpNZ9xrrHrhJGIPxVhNwU/s3cImM6zUIXeX1RBtxbwaC1CXS2mc1smeR/W9tC7fGXQH3bgaQh23I5fqcMKXv0I5c0koShD9ZPr/v5CgGUEg9Lk8735k+7c6gwESNGXrqGKaqwI+k6C6eMnHY508z8=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987289; c=relaxed/simple;
	bh=j8j/C/LDUxiw5Kg141MCogACtfhr61VhYNRd5DV0ZPM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PJb/RpEV2eghLqSPXmkh+h7rzrv71SmT+v+LC5UYVhATv+6UqYfxKg1rusSrX8K2idGGVdxN2KwZe71bgReCcjVIZ0615rV5SHMHORXAKNaNEoONJoFb3Me4Lldza+ZB4/JR/886earEmsePg3mX6TfRCM5+CrIS7can10hga4E=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KjFrGoRX; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KjFrGoRX; arc=fail smtp.client-ip=52.101.72.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YDol0+8uATKbaSzyrybWcmsOP8rTQL+tsU9Ap7b+0GYWCBwDfhni8PbK8Qv0XDXXSzs4pSQt38o9JwWATUbIpo/57Y9TLkSpiU4XcIQTcyg+FgQfxkvoQ5Ldi8HZyqj/o1GTdSoOnaiqxGfoc1sraPlf9FspUioYjtVUXuiXC1kTaZiO/XC1XEQ2AE2yjB2qH20HCAioneYcS/EodAzIdgFJCBGm8isl4abVeRjELO4rmZpNb7YniQ4sdRqfBlBR372D2MioHRPK7RJqbuqk6Bms78SMHESzalzflYj3AS1gxkjnowPkzK1NDpMGxnFQv17dPqKPxsG6GU/yCgmqmQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=DTgEID7NB/Ny673kdjXxhOYVe71uic/ChTKrv5GUb2VoPt2lf/yai3nGoQ1BSCAYXYbub7xw6wD0wKnmlUIoSgDrkdQslVAKV5EyyqZlsRvI+gRVAKD5Ib6v65XKVRWp2uYE6kIqBnTL4gjVFJTx13TmZOh1hk1/8p9dCWvqht67xvFP86XkziL911CoKjA2yp1s0/3D1q4tKIn4jMNnxXarsH+P73nmFVUS/z0mkYm3YO8DTlci+Ar47PPzd+kHq+c4WrYvZGxpwxSpmL+WrtRXiKZAqiIFyOcmAQyz7Wd75wn2cbM2oZireUMTLClenhrd7lUZLZvy9VI9ouQmaQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=KjFrGoRXJGsus/QB7n/cLiXWjl7KPvto8ID6KxKzZ3FovBoJsszZnPWIWitzb1LDG1GD3vbijPBW0PWr303jSSZGhwxD+9QHSz0RHtGe1ebmU6C3ixWV4fP+Tu7IAet821SRf+HHGJF+tfcj/8pb7w/Pn8SGeN2o5II89EAKa4M=
Received: from DUZPR01CA0297.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::8) by DU4PR04MB12083.eurprd04.prod.outlook.com
 (2603:10a6:10:63d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:24 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::df) by DUZPR01CA0297.outlook.office365.com
 (2603:10a6:10:4b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 09:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 09:21:24 +0000
Received: from emails-3106358-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-21.eu-west-1.compute.internal [10.20.5.21])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 500B180063;
	Wed, 21 Jan 2026 09:21:24 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768987284; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=mlv680gQ421phCA/xrPIfT1dhnSJ5QzDReEVe7SUmasgihAhvHt0ceWE/zBauKu/EbYpB
 +GgTM9+lS5rqkObJdYw8ymtu0WKS8fAtklSQUuOA6QCGhSbjDDzmbTHoKLIkypOyoyzuvMM
 4fLE6NenLoKqGqeJisWACN3pgKlYRYQ=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768987284;
 b=BbtbGuY2ZJEzqp5az4MGxnmE16uJlXUkHhoSI13cfD4nOkYs4x53/GV4Q2TrxG3snQCXJ
 WLZbcWDY+b+cAQw68cnHnGWIP3AyPTJ6gnV9hi+KT87RvcicEkyxfntEn9XWuJJqCPcp7TM
 DPeug+TmCy7sJJQcJrRn7DanXDRMNRU=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwS1ZGGN5a5PT7XT8Lw3ZBhwrfrjnq6VQR+haM3GrE0EXHg3AWEz1xt27HeHL7Jw5wyV3F7fAMDfNKuSLkPWSpxf1yNahM2BN7AdKswoTqzwMx8yoe/An5XDADeEddNcZ4a8ffjSoi+RHnyL4vSdg0YXq7Duuuu0KLAE6dezEG7TLzJR57tQpTU+SFWIR42FNuuz6S9uXllnsw/+DCi1EIZVLQ9BaMCTcYOpkOlFt/tKQH4dDkDLDLseSoutopKjuYZY5EmtsWLUzt4FmUzA0neYBpTSmT8vRnRf5QJG16gKLo5vKTOo9Bb6qahg0HR5FCV5dcH/Zk0ximHyjfU9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=IKNnVna5keelKYfmYvbWnL0sW5pTnD8L8AlOlQgPOkIyWrBSCojnuwK/HrpCpuIP3rqiT+itRq5TTif79U6bQFyv1SJYtoPt1om4nK4/Fum3+BbkGeUaabkN6NlYa0WLafeNcVqvTHvf/QgyJxOA7tk89LOVJsQBdyWoPHdsWW+07e4jUUeh7gYE413xk/GpVQG/KKKj2q43dSw+wLYMilnlcjTBjAVjOaep3Rz41yX9B1tQI6GDu+hbFZeUsM8fqeYgSpE2ld9heVYOLwwq4JK8ZNNjvgaZMO5YlNSZDVA7nR6nE7tJIx+m6MFnw61dTU4DU+KynYkdlbYOTkadrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=KjFrGoRXJGsus/QB7n/cLiXWjl7KPvto8ID6KxKzZ3FovBoJsszZnPWIWitzb1LDG1GD3vbijPBW0PWr303jSSZGhwxD+9QHSz0RHtGe1ebmU6C3ixWV4fP+Tu7IAet821SRf+HHGJF+tfcj/8pb7w/Pn8SGeN2o5II89EAKa4M=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:10 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:21:10 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 21 Jan 2026 11:20:44 +0200
Subject: [PATCH v6 7/7] mmc: host: renesas_sdhi_core: support selecting an
 optional mux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-rz-sdio-mux-v6-7-38aa39527928@solid-run.com>
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
In-Reply-To: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
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
	PAXPR04MB8749:EE_|PR3PR04MB7436:EE_|DB5PEPF00014B8C:EE_|DU4PR04MB12083:EE_
X-MS-Office365-Filtering-Correlation-Id: de9e4ee4-260b-49ca-a67b-08de58ce72bf
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WUF4L040T0FWZktWVXlIalo3N2lWTjhPeDFzOWt3UG5Da2QycmxuUFowOHph?=
 =?utf-8?B?aEpMS0pEWU54OVkzcFFaalpkV3VlK2plak5ydHlYc3dOWkl1T2R6RVlxRHZS?=
 =?utf-8?B?U05Sc0Q1TllRaEN1ZzlDdFV1NlR4ZDNzOTdHR2ZsUGNMeUNZaVRlQ21oZ1Jy?=
 =?utf-8?B?amx3akpGZFZmeStoQWVad2l0UjB3UW1kZ3p1cHlMYkRvb0hMOERDZ3NLQmRW?=
 =?utf-8?B?c0Q1QmFkdFNYTU5GU2JHVDBKbk1PQU94cDNvYXJ3YXp5SE81Y0pRcGw5bk9o?=
 =?utf-8?B?VWF6WjdMSzhZUEdJU2VjU0NpQU0vV0JFUjE2NUNudzBmYzIveWhkc1JsZDIy?=
 =?utf-8?B?TVBnWnFrY2dnVm56clVOL1o1ZC84Y3JTNHlBeGpPZ2Z6Ui9xcnJzNjRNaGIz?=
 =?utf-8?B?T2FzVjUzWGlRSjRZNUtEVzM4aTFNWFVpeW5rR1lrVElHc2RCaSt6WVNiTjlx?=
 =?utf-8?B?SVFEV0F4d3BFRk9yZmFTVXJaSTcwanovRFY0Uk1sNlhZbkdld1Fvb01jZVdZ?=
 =?utf-8?B?VVk4ZlRzWUFBT0VkUDhpMmEvN0RzdTFUamJtNmtMUFFxbzNEUzBTTDg2dmRT?=
 =?utf-8?B?VzZtRTh2cFJGQlVOQ1JVVVFsM2ZHWHYrVG5vUmRRZllLUXZqRTJCRmZlNml1?=
 =?utf-8?B?cTlmTzU5OFNqbEtCU05UOTc1ZmN2RlEwd0NkVTR5dHN6MkV2N1NIdDJGMjVW?=
 =?utf-8?B?dllLR2QwSnlYazdreGNsMlBmMXlxdUw3RTRSYUFybDcxUVdCaXNWV3JoZmkw?=
 =?utf-8?B?Mnh4blBERVc4OW5xTGU1eTFoTmk2TGtqOERTQXBoK0hLSjJkbUM5cmVWUisr?=
 =?utf-8?B?NW80eitCeHRBWEdGQmhUdGxlZkg2Q2tPRUxvTW9tRTJKSXJqZEhjcmFHNTBK?=
 =?utf-8?B?bW5NWDVBdmJkMEQ2RjVSVGFoazdSdFp6MjIzd2Uva2N0NGFtT2dJbHhReEh2?=
 =?utf-8?B?WlVzNnBvd1ZIczdvdk8rUnRBVFdyZUhmSlFGK2x2eWVWWVoveUtwN3czdzlV?=
 =?utf-8?B?N29zbWpVd1BJb3NIdm9lVEZacHRXSkRSblpMUEx4ajJQMjdKL2xoQS9EZVFF?=
 =?utf-8?B?OWowbFBnczlnWnd6aGRDM0FLNXFxbFJOS2tQR2x4aUw4eGFBYWMzWFN1K2ZO?=
 =?utf-8?B?ZzV3OXBMVGhIRTlEaFQvY0hPZGx6Vm9xMlpmak50cWZjajBhc2thRUdnQ0U1?=
 =?utf-8?B?cmdZQTVyMmpiNUhlMEN4QVgzSXpaQXZyRmkyYS9taWJTQzdLMSs2N1FBTW1L?=
 =?utf-8?B?SjhkUDdSVll1ekh2QklSd2ttRHZka25sR0JVOENCMkpBeFlvVldmRU00OWxC?=
 =?utf-8?B?blhsWDJnYVRhaE5JNFZhT1BzU0ZTekNVbldYcjZJWnQ3eTFaUWdrYzRpaU41?=
 =?utf-8?B?anRPdTNKaS91SVFSQ0hYZGlLYW52OEV0c2FjbkhtT1IvOEg3bFJCZ0tzU01Y?=
 =?utf-8?B?RFVKL0NXL1FQUkl3c0V4Ymh1aUl2OG5xQjl6VWxCWUtnOGZPeml4Q3F3L1BP?=
 =?utf-8?B?N25XMkhQemlnOUs1c0JFU1Z3anAxVWMxUTAzRHcvbUpCVDBpVHIwWGRYcU9z?=
 =?utf-8?B?NFNDeitxMHFHeTVVNjgrNUJlam1Ld0hJc3BPbU5TY3gxVUFCS2VtS0tQcjJz?=
 =?utf-8?B?ZDE4Rk9YNkljVUFpSWJpK05Ha2s3bm5vcDM5SHRrTGxOeHVFWmNqMXlQSjQ4?=
 =?utf-8?B?bzQrelZjS044RVEvSkMxRkFJWTVST3VHaHBQYTIxdFRxOEUyanVMVi9xQUdV?=
 =?utf-8?B?VlRaUStyNFdEcDMxM2tsTWtCSWhDZ2IrT0xIUTNHWDh2ZnRkb2QvSHg4TTZm?=
 =?utf-8?B?b3ladExlY0gvUkdrdUdmcExxc3o5OW1FcjZnSUwrWnR2dklRTy9lN2JJOS82?=
 =?utf-8?B?aFl5Tnphb0VqNDhFWUJqaER3LzlDQ1J3WFZxcFM0R0RWRGdMb3RYVi9vL2ZW?=
 =?utf-8?B?RSs2RVRhSitZQjFtYXF0ZjY0VXBtZ1Q3ZnNqb25DVmtma3RrTGc1QitXcCt1?=
 =?utf-8?B?TWpHWndLRld0RFVmYjFIejFOYnpLVk9ralN0OC9mVm1zVVFDSFUvNHZ3bUJx?=
 =?utf-8?B?cW5FNVRvM3RlVk90NkNCczFhSzZpMDV1QStaRURpMWxDU3A4aDBXZDBlbHZp?=
 =?utf-8?B?cVgyN0d2aEFkUVFndHFnV0xaeERhb3VseTI0MDBFc25Ba1AxZDhnSmJMS2pS?=
 =?utf-8?Q?a4Fzxbml0YJKPcxELmtEDsUTinjPV7Q9RK5G6F/2PoG4?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 550fa3086a2240379faec55bd6a3ad28:solidrun,office365_emails,sent,inline:8406f9cb3e46051fa2a59ad8ba71cfe5
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	13fee9f0-758d-49df-dca4-08de58ce69e5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|14060799003|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTZpTjhieENzV1pzano2UDdqYjF6VCtvdFNBV09EZ2NKNjRLamUvUzBNTE5u?=
 =?utf-8?B?WTBoMys2OEZVZDdJUkJyUlorenZpY0hIMGZWcE4raXNveEFyUXVqQXZuWHV3?=
 =?utf-8?B?RHM0MXhoSjZuaVFmK1RaOWluS01FZWZPUGp2cW1SL3ZpV29LanUyNVpCeWZF?=
 =?utf-8?B?S0pkcjlWYmM3NkxINnFsLzl1bTUyN3FieDRyc3RmK3RNVXQrY2dUS2lLMU9P?=
 =?utf-8?B?dkJyK0JsaU1PQ2NodzVoazF2VllaQjUzcHNNUjltVFBBeW5Ob09UdkpzUjVL?=
 =?utf-8?B?Rno3dmlHZzhFbU95VXdsOTlIK1JZd0V5L2FNSU5RaVE1U0tlVzJHeGMxUlU4?=
 =?utf-8?B?OEFnMUVEM0dmOXNYYzJBWWdpQWVJaTgxamtFbHdRNmNXcGZoWHNsbUNPbkxM?=
 =?utf-8?B?YTdFMjZzVWdiRUFxOXhYWHBCQkRoV2RoYkJVeXVUNCttUzlyVkcyK08yRkI5?=
 =?utf-8?B?UDIydHVhTTJXNXl1TFVRR1ViV2l0eDBGZjJPcFBZcFdickZSV2FBTkt0d1Nm?=
 =?utf-8?B?UUxJbG5QRUVITEtERGZ1RW5OcCt1OC9RRHExdjEzbmZTREsxZC9MdjVIT25y?=
 =?utf-8?B?WUpCeDJ1cEoyd1lhSmt5T2hDY2NtMEpOL2JHMlJnaXMxbFhzblVsTlZuMEN6?=
 =?utf-8?B?cVQrazNNOThaeGxSdmxBR1R0VEtrRm9lcXF2OVZuOWVTUEZKZE1CUnlmaldq?=
 =?utf-8?B?RWJwYWdFTmJGeWRQSnUrbGIrcS9Fd001akI5OExRRWNvTUlLOElkRjJQSlBx?=
 =?utf-8?B?clo4SHVBRkdON0NLUkhQK24wNDEwY1pVZTFjKzB6L3UzdTVnb1NxM1pacG8w?=
 =?utf-8?B?TzNQUUc0aTNsczEyaERYME9Xbjl1SktmOUxLRFlwdklsOUc3aEN5Qlhia3VT?=
 =?utf-8?B?akRZc0RaL3ZPTml3Nmh4N0x5Z3JNUmZXY1NtSy8wODdtOTVoR25ieXVpbjJH?=
 =?utf-8?B?TXRrS0x5aFZPNFdkZUJHUjJLY0FMS2Z1aFVwcWZEakNaVCtiZEZnOWsydXE3?=
 =?utf-8?B?Y2c1WjlMMjBRU2Fnd1FKemNMLzdrNkRnSVhZZkJkcWhsejlralNDUERReDJz?=
 =?utf-8?B?ZXg0c3c5dEc5MjFQMFQ0R0xTTHhOcTl6L2d4MmlrTWRFSVFtby95aFlYdHFp?=
 =?utf-8?B?UnprM1RMZXRiOFlrYnZucCtoZ0cxQTdib0hjcjVNOVlhUmtzSWNWdDRJSmF2?=
 =?utf-8?B?cHdINk03TXRjSks4K3Z4eVdUZlBJbktkY0twa3dhcDdEb0RMdklvT1E1bFhX?=
 =?utf-8?B?c0pqTkxaN2J6NVVPVUN3QllGbWEwMGhQY2ZaM0RwS2VYNkZybUsra3lrTDcx?=
 =?utf-8?B?a3lYMDFVVjVGREFrdWtFUnpmQldXb0ZHbjUrdlNwaFFEdUtkSnpqakNuVVVQ?=
 =?utf-8?B?UTZMYjdzWlVjUW5BenFKV2lQTHRzd3M4NW04TVo0dWNTM0FId2ViOFlOYkU0?=
 =?utf-8?B?bTc0QW96L25LcHFVZTVQRFJmMTRmbzVLNENyZzNtY05BejJqaTRJS0hiV1lm?=
 =?utf-8?B?cE9xV25oZTdwWldrNmdZRnAyZmhqdzJxdG5oQ0xNUEgxT3Rrd0JpQnNsQVRk?=
 =?utf-8?B?STRmTzIydWt6MEYzRlhJN3pUTHQyME16UStOMGcrVWlCei8wU2x0Vkgyellr?=
 =?utf-8?B?U1B1Mjl2Qm4xbnl0Y1JqeU0weVhDcGZreGZ3NEovTzFIcXI5MFNXVlpxUVpa?=
 =?utf-8?B?THNBb3VYWWVVTG1SS2U3Z05TaUdKZ0t0VmpWNEpNWUtROGZQTnlYWGwyck9E?=
 =?utf-8?B?aWRBeDg5ZWRIUG5Ja28zWjN0TXNBaGhkVVY1UXNCL293Y2M2SzNtM3hiMGkx?=
 =?utf-8?B?K1NtYlpBSkNYSmt6cElpdVJTU0x5SnJ4WTZvM1dDTUVGZzFpYzJpVG00SmhN?=
 =?utf-8?B?bVFaNUtVcGJodXdTWS9YVjNyNFIzWWdKK3Vhcm9iWWFGMENyUHFGZVRRc1pJ?=
 =?utf-8?B?L0tLc2JLdGlaVWVDN0xsUHBLaW9mZzRQUisxelQxem1HeUdReEtCdVc3bkJM?=
 =?utf-8?B?LzE3UmRuSmFsL25zWHNaN2VzemN1bG5JVzRFZDM2cG9wNFdqdnNLeGhkQ0dr?=
 =?utf-8?B?aUhYZmtSNDl1dld6bkwvcUNMSVJyUXkwOTgrQzZwd2NkUTVLM3IvVDNTbU02?=
 =?utf-8?B?dExpZlptRW5pNGFRS281NEVJeFhMcFVlSC9HSXJDVjVJZUVQNUNGcU9PbzUz?=
 =?utf-8?B?UnRoMG1LRU9hS0xwQ01vMU4zdFU1SEpQYXNPZkhBTW1DZjI1OUZWcGxEd3JP?=
 =?utf-8?Q?NhnDDKZJbQU6AyIQ52F8L+Sm8u4xh0TU9c0haxqrxk=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(14060799003)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:21:24.4434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9e4ee4-260b-49ca-a67b-08de58ce72bf
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12083
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6245-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,glider.be:email,solidrn.onmicrosoft.com:dkim,solid-run.com:email,solid-run.com:mid];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3C7AA547CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

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



