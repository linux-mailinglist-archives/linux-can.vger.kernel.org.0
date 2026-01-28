Return-Path: <linux-can+bounces-6346-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJpdFfwiemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6346-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:53:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77AA3473
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F64330048FC
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBD436604A;
	Wed, 28 Jan 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QMj6VGrO";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QMj6VGrO"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021129.outbound.protection.outlook.com [52.101.70.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0A364EAB;
	Wed, 28 Jan 2026 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.129
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611608; cv=fail; b=RCPFQaMaC4NXSRC8NX3woy724sYvzw9A0t9Sqi2Y+SJclAqMuk04JmBArwZ/EIk/ahTSznBUR2vrR0L0q/Oe90Vp9qktWBM/lvVX+3Kksui5WHk1Onc6A5fCfLZgGqWRwYESaap+jYZOx5zBqoqt1LinkA6OVBMjTfZpo3yz12o=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611608; c=relaxed/simple;
	bh=j8j/C/LDUxiw5Kg141MCogACtfhr61VhYNRd5DV0ZPM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uhLsmESLTdOo694tVlg2wnj+SqdlJkSXCe58csY4oCxqIEhD7j/2LCM1EEyWYQ6jdkc79AXIvcj5eXOpkW04mfkZrmMYp3Df5nPNxMd1bHHMV7KeiyyeAnB1ykHlPIBA4bgwgQsTvBx3y2MJJET1NLc/N6BZXjHtqvwd1xttHvM=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QMj6VGrO; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QMj6VGrO; arc=fail smtp.client-ip=52.101.70.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qBnLoRz1U2NknJrmqslgcVjsIpWVdK4DkMF8ODKon3ZC1+SX8ts6rSo7fwGcTtJKbQ09RRSHTvz5ncNrGQFUfv+J3w6Obksgipp9pqWoA4hWCuiDGENokpOr3mdF32i1/CjeoZFF25nCEih4JxoSq7YGXc1uPvgR6diRnUi1EtVyruWIQaKO5fGrky9iXh3ZolabjojDfm028g5p4XYAmxqdFKvxveItS/updyVmvQCdo15K6FMvS6QohboaYzl3tMFC+2eVxK0C0M893rB7PV0Z4VXNAmkO+UTp/PtwbVradP2xLOGGgyeJdtsrzl3oYo+c1w96xeIcocZEro+JIg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=lI0pr2z1P+VJA0WJIWZEfyGo1AXF3xlwHzpJ1H4En3qOQJDdDnY9wPG4rf8RGjIl/IIkrUOmC7YANRLkhY18mWG9VyG88Y2ksLcTCIBOZLAHlFGcxR6+Nda31syRnHx8UJzYOW7em3MhQ8H9EsdU0bQxRA+C10vjnU84cUdzqTZrsmFlOtdJxhuER6JRexnNMera5P3j81kkYVtkXOPPHEAMojjAqVQBM8ilWUGwVtjHG00iJ61FaaBHwZAXPob6FKnsLdhRK3/fV4VQvZ/jEAtyknkSOM/KUBLrvjxr6gZWNSAg5Exi6yxaBRVBYvsg0W6ZRPkOXSa2y5bZn0ZhzA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=QMj6VGrOUFJlfOXPgdG26vuWmwTnBafcHiP4kxGaPInoyLal0UlcJy0WRyqdD7IVe+8CTLvo5vXEBEI0cp+0Idf90XIs1/PFyld2BmtQQKQjArE75Fz2Se51v27tJe8MJTEpOvM+eMWgJgKq5xkK7QVOScdVe6TbRjhUcDgW/b8=
Received: from PR3PR09CA0030.eurprd09.prod.outlook.com (2603:10a6:102:b7::35)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:46:42 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:102:b7:cafe::cc) by PR3PR09CA0030.outlook.office365.com
 (2603:10a6:102:b7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.0 via
 Frontend Transport; Wed, 28 Jan 2026 14:46:42 +0000
Received: from emails-2666495-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-155.eu-west-1.compute.internal [10.20.5.155])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id A559680690;
	Wed, 28 Jan 2026 14:46:41 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1769611601; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=GaNIi6RuDgcdHHpBq8DoySZ/fW6NDb6tLdHxlXP7vw3vYhNu9R5IaQX6VUdZLq/4inWph
 VSMRS5k91X1hXeuFSOVc+E1AWa9XBMDHK+ZHRfjkZsrFL7ldes3OUc3s9Zg+jU9X8aE9kM4
 wS11A6aiv8RywodETqiAsNQTmyffB30=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1769611601;
 b=n2IxyDrU6oYsNqpgPSFfturF/7wlOyc1DO/7ZtVoKxbjGfL3ImyYY+18EsYrWg4NvYU4r
 1FSj2wXAigNmNHF75IQFIRZznWy66wHLz2X7YxVc5Yz/6RGrVYAb38Ez+W76+2rbCUFhaiB
 C9EFZpumc90iLeBpMU02T5fzbjc8lSo=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuEMAjHZfMKzNLbaG2tLqODTJ1Pd7QYm7QQXDDSCf1EgaBxh8zFT3tYCQt7+k2b8WBfZpdhyb4ilVepSMOf8fqGQamtpYtWyg4o7aKf1JuRHJfXbiFpg6SpfTc/s9uqy/aj+j5ALgjwr+LaOIBLq4btN+U1MBif9zrVXXXnzk/l+SxfWOwx0e1dih6LBfHpM9d5kAe6QUmFIIjmlJoF9FeH0KDlRyvu1cv9ECHOf1GxqBVvN5T6U6Sen2P3hkaySXMpVQ+3PPSJgcQI8xFT9jMzZPEssprxX1qbduZC/Xc1/JBZ9INmC0mRxcr/1BLPNVhUzsZNM/bJZo2T+ImC9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=m7iYS5YyVRRo6x9sXRtRRjY56P8jWfXjAf1tAvPB6pPbaSpBSudLgtgLjOQYD8T2WVMaU6U+/6xZPi9hurZOm1Ex4jE8ZAqOSWR251V1tjjjZjn4+T6BVKEOrvejE450HiMETeq8r1lkGe6XrO9+t97SYwY9x0LP3pPAgixkz8Ibj6IJo+O9tAXJXYyvTGbjmbKwBpExqsoEjKjOFBBzy1JJxH+H7gHOPbKO7uSXPJufYEaj/tDXnCn5af/yCbh9Y22SM4rFSOFfG99jHwzSCEbsOvNegQXA5LC/xUToqWzurg2FD5nVsImx2E1GpgN98aAdE93J+UrfifpL/SlEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=QMj6VGrOUFJlfOXPgdG26vuWmwTnBafcHiP4kxGaPInoyLal0UlcJy0WRyqdD7IVe+8CTLvo5vXEBEI0cp+0Idf90XIs1/PFyld2BmtQQKQjArE75Fz2Se51v27tJe8MJTEpOvM+eMWgJgKq5xkK7QVOScdVe6TbRjhUcDgW/b8=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:46:33 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:46:32 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 28 Jan 2026 16:46:15 +0200
Subject: [PATCH v7 7/7] mmc: host: renesas_sdhi_core: support selecting an
 optional mux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-rz-sdio-mux-v7-7-92ebb6da0df8@solid-run.com>
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
	PAXPR04MB8749:EE_|PR3PR04MB7289:EE_|AM4PEPF00025F96:EE_|DB9PR04MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5adc90-1500-4a45-83f9-08de5e7c0d21
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?blhPR1BqelF2dUx4VnYvV09xNFZQODlMS29xbDlEaUFKS1cyMlRUM0h1U0pH?=
 =?utf-8?B?YzZTU2kxbkFBMnh4aGRuMEZaUDROVnRLS1JZTW5pdWFqOXQrRkRyYzFSMGV4?=
 =?utf-8?B?VWNlWU8wR1RIbzJ1NXp2Qkl2bm9hMWtxWHdvUVdwclNTZG5zWUM3cVRIck5a?=
 =?utf-8?B?eXJ4UmxhZ3crWFIvSDNQenRLNXBaL3NTOW9RMHc0M1ZLb0ZjaDF0VUxXbVZF?=
 =?utf-8?B?S053SGJPaE5OR1IzNzBjaVZvNHB6aXhtYm9tci85c01BVTlNR3hMSmVoSSto?=
 =?utf-8?B?YkNxRHk0WDdZcXhtazVhY3czOHNqRXRiR1MySE9ZekcxOFZXWWwyTHo1dDhy?=
 =?utf-8?B?NWdGSnlhbEFoK29vdXk2ZWdJLzJyT012ejJPVTg1S3ZFQXMxWjdMVkl1cjd2?=
 =?utf-8?B?NWREMkF4dmYvc3o3QWdzbEdMRWhDL0pJRk5JSmZ3YUlDZ3E2V0JmTkVEcFky?=
 =?utf-8?B?NzJSNHh4cHc1bmFkZGJmQzd0NEViNHErZCtZYjIycUtyRTNRa1l3cURPaTJE?=
 =?utf-8?B?UElnNTA4SXZYbXNIYkgyN0tQYW9jNjZqR0FjRFZ0aGVTY1FKRi9QZE5yL2JP?=
 =?utf-8?B?YXRnVUxuUzVuM3hoNVVZWDU4bGxZemNEeitNR0Q5Yzd6RVJqbExxSWJLemQ2?=
 =?utf-8?B?Rk9lVmE0cXdPTlcxWDNTQk5aVnY3Wk5qMzdkVjdzWEsvUUVydkNDU3N6d0dN?=
 =?utf-8?B?OExxK0lUaHZHUitDeEpYcWZ5TzZKYUwwdnlyNWV4TUhOWE9nNVZObmF6cHBP?=
 =?utf-8?B?MkdnZ2k0cmkrODYxOXYzL3hTYVhjWndWdytWUkQ4Wk1sVkZVTWxIQXY4VkYx?=
 =?utf-8?B?aWlkazEwa1NucHFSUkM0Q0ZwVWt0QTRnWngvMWVnYlc2ZW5oK0MxNGpVMTNw?=
 =?utf-8?B?eGU5MGkwL3BjZVM2U2h3OUNDQS9xWng3N0V4TU82V3NGcE1ueGxRVUNwcHli?=
 =?utf-8?B?QjJrcXp5Z00zZnQyanJsOFBwSXJSbllseUN5UEVKQXZmS0pwNXUxUkZwbmZI?=
 =?utf-8?B?bmZwYUhSY1lhM25Sd3V6MWx2Rkc3cFI4cW90T3B5Uk9sWGw4SXlrT1E1QW0v?=
 =?utf-8?B?ek8wZjl3b2dwS0tsVVg0ejdadHlWeWxyR1pDOG1rZFd1VnFiM3ZZcEdUMHFn?=
 =?utf-8?B?dFg2YlZNVy91RWE5Ris4Y0NuM2w5VGFod3VTR1AxaThsVGlPUkM5MGozZHZL?=
 =?utf-8?B?a0t3Zlp3MzVkSWk1ckJoOUdpczZadWV4bXVzMFdpeWo0WFgvbmlOUTdQcGd5?=
 =?utf-8?B?RkxXZ0tSOVovQW83Q2k2eVdFK0xVNkVxcTNEUVJENERsRitlS3UyRWJCNGt4?=
 =?utf-8?B?em9rdloyVWdjbXlUMTFzUUR0ZXppU2pPaUFyQldETnpPak90ckJlcERLdjMv?=
 =?utf-8?B?Qzdtd1hMLzdES1JYaU03OE85Qk9NS1BJZ3B5elphbTZFbmZjWjhyVHcxM2l4?=
 =?utf-8?B?TVppeklPM3dOL254NUluMElGRUhKSWdjMjhPSW5IRXNBNzdRN0ZXWTdyWk1M?=
 =?utf-8?B?Z21xbFJnc3o4T2RRMmJZSCt2RDgvc0E2aEpxakRCT3J5NEQ3VS9wOFRGdTB4?=
 =?utf-8?B?eWo3OFZTMWQyVk9qcWxyc2xQaXlMOU9kTXR0R3Fvckt3dVU0NHh3NGNxVkcv?=
 =?utf-8?B?cTRJTGRqdkhRdWJjZ3ZrZE1YQytwNGdOTzAxMzhxZHFreG82NksxdkNUT3Zj?=
 =?utf-8?B?bU44djYyZkZZalpFQnBac1ppemoxZTBWMWtXNUhuWTBhbmFkWHVGZS9FbFR3?=
 =?utf-8?B?TEZuNWNDWjNHZVErTk9ZclN6WnpyMnNBWUJpTHZjcXhMcEdwbUVWclRiQ1BK?=
 =?utf-8?B?cGNOekZVeHlSaDE3clk3OGN6MVQxUkhpY0M0bHFEUzdNcG9VR2VKTThyd2Iw?=
 =?utf-8?B?TEJXYTZMNy8veEh1QXhROUlELzBDWEZaN2xqSzR4MkJZc1NzM2hZL0IyeEZz?=
 =?utf-8?B?RDViVXB4QWNaemloUS9Od0VaYnNMbjdnVjZsQ0ROV3pIR0VqWWFrcW5PU2FK?=
 =?utf-8?B?cFhyT3c2RFpaL0hwanJ5M2NWY09sZFp3ZVg3aUN1Qkl0M1A1OUxzTjFNa1h1?=
 =?utf-8?B?V01KcG5xaC9WR2RvbFAvV2FXQnphV2dMeVY3OGJCYTg5U0QxeVNOcGFVOElU?=
 =?utf-8?B?b0tSZWRRNHQza2dOOTZrOTM3MGZoMi81K1ZFdzdnckpsQXdrWUxTaWNjSW5X?=
 =?utf-8?Q?g5P9dldOWDLQTt4e//a4LETepYSQAsfF94fzUi9Itqcg?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d414303f4f9547f7b05bb7a20ce9b28e:solidrun,office365_emails,sent,inline:5c927907a0056d3547fa923b049e9e5f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	788c8df1-6725-47da-d656-08de5e7c077e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|35042699022|36860700013|82310400026|1800799024|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjQ5NXR2UDdpcG0wVlpDd2ZuRDFkaXVhemVXV0JkZFpWbk16ZDJPZHR5MHFl?=
 =?utf-8?B?ZlQ1TmxGYSs4dm1FZ29CYnVML1YxdmN5aFoyUHFCV2Z6a285M29vdmFRVVhm?=
 =?utf-8?B?NGQvTVIwa3Q1YStlVWhJbkJkK1h5ZjVJYWRnRDNZUHdMY2FybW1OVDkyS1hS?=
 =?utf-8?B?QkxTcmkzamxLamdxUHhkL2ZvWWsvRXpHSk4zK1JBdmF0S3QxbjRJOG1Pdkk0?=
 =?utf-8?B?QmF0eDc3d2ZCZVNNT1BjYUQrenNXbmlTZlUrNVEweTR2OHJnZCtYbWJMV20x?=
 =?utf-8?B?cnJKNjlNbk84N2I1R0UzUnNVMWgvUVY5NFNHS09GaTkxekxxVUNsRml0dlUy?=
 =?utf-8?B?cndBWFRsdGtCc1c5ZElmQTQ1aWFLQUxlbnpFRytaWFFTSzAyVHFrU3UxbGRD?=
 =?utf-8?B?L3BYUHBIVHl1NXpJR2ROVG1tTHV6VURuZGpSOVdRdHVlRjhSUmpIWFg0R3hh?=
 =?utf-8?B?bG42OTRVNk8vRFhUVkV0a0MrYTkzRVh6Z0hrUHFuOEd3ZnZLc2YvRWtQRW0w?=
 =?utf-8?B?U2d2RlkwVWw5Unl5V1pNdmxBSzJ5NGlJN0kxdjRQbjhZT2FCMEorbVRpVEh1?=
 =?utf-8?B?bEd4UjYzS3BLamRhL3RFSmprUHVlNjlDOVRpZS82OVdFUzMvcjBtMzZVelRX?=
 =?utf-8?B?UWs1TzgxN3dkMVZmdVZ2Q2cxOHJHdTF4YjZnQitLTWZjNVFLKzVTbklFUFNN?=
 =?utf-8?B?ejhtcys1MWRteEh5Qk4yYTVSN0NjUjNlY1pwazJRTE5ESDVpaG1VUHdQZHVX?=
 =?utf-8?B?ejByOVdveXNhZzN4ZngvK2pOVE9sSWNxY2dST2lGdjhRRkZlUlBYbnVkeXRz?=
 =?utf-8?B?RzZUZitGZTl5bWJ1QmVxMmlTNzFDTkY2V2tqdUhNeW9HSU1JZ3ByUVBiWDVJ?=
 =?utf-8?B?dVNwbFR0M2pWTVM3S2dTcWh3eWVrOFJ2WXNvRDV3TzdnbUhMc0VBSEtrUjhY?=
 =?utf-8?B?NzVlTmlzWjNGbjVlbGk3UjdwT042MVh6Q2JraFdGU29HN1RVWnd4SlZlT1Jj?=
 =?utf-8?B?WjZBdGdTaTY2cGxIVWY5Y1dOUC9nc2Q4QUMwaGxwNWZUR2t0WjFCVUt4b2px?=
 =?utf-8?B?UXRGeFVhQWtmM3FoZ2VMMFcxOEpQcVRUNTBaM0pjSkdqaEhCU1F5WERaMjNI?=
 =?utf-8?B?bWdRVUdkRElFZHIwR1ZlUDRtcUJtZ2R4TUhjOGpydkNPQjNIQTBWem9GYnhD?=
 =?utf-8?B?eHhFYTdIWWc2VVNXUXNaS25ybHQ5MlFzaWZ2VWV6SUpUYmhtK2hhYkVpSUdD?=
 =?utf-8?B?MlJkRURyVUpMb3luZlZkRUJMNTZaaTlSWUJLKzI3clJJWGRnWFlDKzc1c080?=
 =?utf-8?B?TFRBVTZkZ2NTcUIwK0ZwVkhGc1ArVDdhcC96UXpuMTRQOGtwQ0VDYUdqdkdn?=
 =?utf-8?B?bXRta3FnZ0REaGhmTldWd0h2aktWTCtFbkNLNnRvazR5YXhEZklGU0FRWEx5?=
 =?utf-8?B?V0dYWWVGSys4d04rZHhDSzlkTDJqSGFSM1NoL3NSUlYrbk1nSU9ydnhZaXE0?=
 =?utf-8?B?T3ZGb0IyU2FvMjdxWityYmhPeHQrVXFrMjJyTlYxYmVhTCtGMHFFL0F1cVFJ?=
 =?utf-8?B?MUhlN3BLTldxK3JSa3ovKzhnS1pzaE42Zis3U3NTRi92alhuYXQ1RzFOWld4?=
 =?utf-8?B?clhJNEFFK0NWTzJMdkhUWjRyNjNDVzlIVEJFT2JvenBPNWdJSEt1WVNRNStG?=
 =?utf-8?B?MHcrOFhPV1VNL1dNTWYrRit4VmJaQjNXZUgrRmN5Y0V3YnpJZVBjczNKMjhr?=
 =?utf-8?B?Y25QUWtLRysyTFFjZ1pHNm1td2kybVpmcWJFTWhDekhxQzJOTVQ1RWpnRllF?=
 =?utf-8?B?eVAxUWZ0NEFYN3l1bHNxWTBFZGtidjFsT0J5cFlEcHp5OUZQUnBXVUJmMEoy?=
 =?utf-8?B?VUxpLzZRZ3c5VzhEN3VJOFU0a3FIaEdYZXZ5TnBCK0N6bkxKcUdTSkVqcUlq?=
 =?utf-8?B?bmdSaktiaHY4RUcxVU9rWnMrdHVHNDBXMzRrUXdjNnByaFRFcVN6Ynl1N3RS?=
 =?utf-8?B?enlCUGRwRVd3SmNaVitMSkllNUNTaS9vWENnOXN4a3ZSWEVlc3NnSXlDWU54?=
 =?utf-8?B?VlUvRE1HbkpsN0lKRTd6aXA2amZxc2l6MCs1aVNLb09QbHYwRkVFY2dCUzBt?=
 =?utf-8?B?UnhiYTl5c0QrVWpEbjRSZFd1R0wvZ256WnlxWEt6Qk5WV1V6TGpwOTBSRk5r?=
 =?utf-8?B?YkovMmxlVzUrMWZKWkNtMEdCS2Z4L0t4cUZJdHR3ejcrci9QUEI0bzFqQUpX?=
 =?utf-8?Q?vc6Xf5sHQSLw7dQ/5FqUF+mrSw4wkZ4c2+Ysd7oVg8=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(35042699022)(36860700013)(82310400026)(1800799024)(14060799003)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:46:42.1444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5adc90-1500-4a45-83f9-08de5e7c0d21
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6346-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,glider.be:email,solid-run.com:mid,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AA77AA3473
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



