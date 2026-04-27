Return-Path: <linux-can+bounces-7411-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIFqCiVo72lZBAEAu9opvQ
	(envelope-from <linux-can+bounces-7411-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 15:44:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A9473A64
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 15:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D723037448
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2B23CAE73;
	Mon, 27 Apr 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="Drw8TYSf";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="Drw8TYSf"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023138.outbound.protection.outlook.com [52.101.72.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73453CBE9C;
	Mon, 27 Apr 2026 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.138
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297318; cv=fail; b=BNlHY9FxIRsF7IYy81mZk7Wv2OhI0xACfwuxyCcNaYR6l6F0w9BGX8lVDLNmPHSo5FWjMtHRggtIYZXHKU9zUh46QxQ9GJyj2iiElK0E96LxSJMTBPuYKVqkSOho6IwkvEFsR4rZdD+YkfvPpAdv2oGo/sFxyTnUMKd/VfHUuno=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297318; c=relaxed/simple;
	bh=m5JZTTXc5jN6VITqupOHVWSEfPjAG6zAtrtoyHLSxl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umbpHgsUi+KdhpDcyOYoHohy/98p9xK8kNJ1PfILKcKtDLYSa/3wskex58m5lovLKfg0/wQNZ7b0kYP+u/jVRPLL5orcTzYiYJrUHyxGfQe3yvqhQEAHAQByKPvito0+gsU3AVQDcROV7vWBT8s84MoOFNKFEb/GyyzEhdVCu/k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=Drw8TYSf; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=Drw8TYSf; arc=fail smtp.client-ip=52.101.72.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oLOJG6Qnd9OtYa7hrUZ35n0cfTAg7UIrZ9hqHDyaKgEcL0xU05pg/OBZoSf1VjU4gdP3dzfr27G4L2YcnXckxtUbbYDekUUl+Fa+uw/vtuCW76Y8IhIkBYUO6/OomcOixJTaFSyNKEsLpl7dxMNcjPwW61yvYGNFdaG2FN21XfeDbX5xXUxfbudYT09qTtp0KQJWg8FwThVJDScbrxfbObA6Iko15R2Y/jj5SIW8XpjhF4J0ZY6aqsy8kCN0Ak+A42Tnnz3N8Rxa2OznLTKliR0hfcH5MrUGJmsS2Bwr26h3ef3wyzOd2uqrXmfRinsFRRXNua77MohGGy+auxCdXg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5JZTTXc5jN6VITqupOHVWSEfPjAG6zAtrtoyHLSxl8=;
 b=p5PhOvpze0XUOr/kz7d8uoodIi4IFoOtKhsjXGVW6D8C7fOp24zqo5W1GM+eIOmjLGi4BIp/Km6tl66rJUPDE5hUs5sNjUredqH7EHsR4cmuOXNtslkl+xE6rxgLju4d+kqG1tqTjBOE2CtSUzHrcHxWr8+RLNeT3vT+wEWcOx6mXSYsff+4yWhf6q2/LCABr0qOxy/cPP1SU/exnlFjvsQhSoBWLp7A0/5ptFMaLcuQPEGYOmPLHj/gQ0qgNdtCyxBapDPiPrKyjnd7MNqv3T8JErqs2GMrV4hhrVucuRUK9onuJ/PyG7I/mFC+zpsRxfsyGTG6JAF1FeMy6fyQhw==
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
 bh=m5JZTTXc5jN6VITqupOHVWSEfPjAG6zAtrtoyHLSxl8=;
 b=Drw8TYSfPlsjeIXHHM6RrxewxGpN8K8fUJp7uA+fPzbT2hIMyFRYj3bAOw4uLDVbiTHiKJOZbDUYI25f+DVxMmib0jAV45F3gm73RKRamkjRvNSVvcWe+rVLjwmIGpeXipwEXglS3S0Z1YhypoR9mf1qTqxgpTcntnE5OHfseU028hQMHnVDedE/j340fiPNw6wzUyxZ9q5DDrq05HCvHRhdF15VfK+cn9CML9KlTTknZyV55o927qXbwqG9/ygxPu/owwUJsRvZMDNDyXWswrjDgtYbsvnJbzqleg2FPbiIj/g8k+7iBvk4cV9pSHlPINE2P7s+XsXKDw8cDMItkw==
Received: from AS4P195CA0052.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::12)
 by PA1PR04MB10554.eurprd04.prod.outlook.com (2603:10a6:102:484::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:41:52 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::cb) by AS4P195CA0052.outlook.office365.com
 (2603:10a6:20b:65a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 13:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 13:41:52 +0000
Received: from emails-793956-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-232.eu-west-1.compute.internal [10.20.6.232])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1608380594;
	Mon, 27 Apr 2026 13:41:52 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Mon Apr 27 13:41:45 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxKaOEn8PJWMe0JlCo52ebH5yyUjLGn7qKmdcZAjaf5apllmzp1+w8wAZjcDHeKOa8aIESkHpWmv7o3bpVNjob8v61M2Wmp1Y7f2S0dIZVsKHYT8/EcpCFTcWWFYK8RjhqIrUPIDD29b0KDmKmu0Bx91iBGZAAL8Ezq9AFJFoB2XVMB5ILbN9zrzPRbvMJTmxpzbv+X716tYfDkgjyUymHVHbkmaFk527THOCn4CbfK0cZfzp65E4yF+pmSPYZCZcJrvsuiMluZhGbYYB2iajQTFQk+VyAjHYWRsXNaWyaAbcl0bOCmL/ZvtRWkE7SuhhSLY3gA/uXjuah2yWu2Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5JZTTXc5jN6VITqupOHVWSEfPjAG6zAtrtoyHLSxl8=;
 b=cBreeSqdRCijD0qus+fMTmwVO4eQSWtqksGi9c5U3EhmxcFfEMUZpG5NLndrivfurDvFwI2ifOcUw5BseyJlX+s80tzvrazRgrTgE/YrsMls1d1KSGdeY6Ety2hY7gpKfztpeUXv5zGDgse94F+MEVfXtmqYN76QPEqrHZ7TUR6YiSJZKG2amt4E6rVYN61Wlrsmvjr0NYdLth/aG43dHOt4DAQ2jFF4zVeCM5L1J916URfe5nXO1KMV8AQ4pU652/Cx3Oq8v0jHne8+LB/5kfvtDXWocPBWiVxQhYgnpypMDmwcXU3cMudgGdFMxeqgtL4c3ed3i6vl7RsJYJGmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5JZTTXc5jN6VITqupOHVWSEfPjAG6zAtrtoyHLSxl8=;
 b=Drw8TYSfPlsjeIXHHM6RrxewxGpN8K8fUJp7uA+fPzbT2hIMyFRYj3bAOw4uLDVbiTHiKJOZbDUYI25f+DVxMmib0jAV45F3gm73RKRamkjRvNSVvcWe+rVLjwmIGpeXipwEXglS3S0Z1YhypoR9mf1qTqxgpTcntnE5OHfseU028hQMHnVDedE/j340fiPNw6wzUyxZ9q5DDrq05HCvHRhdF15VfK+cn9CML9KlTTknZyV55o927qXbwqG9/ygxPu/owwUJsRvZMDNDyXWswrjDgtYbsvnJbzqleg2FPbiIj/g8k+7iBvk4cV9pSHlPINE2P7s+XsXKDw8cDMItkw==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by PA4PR04MB7680.eurprd04.prod.outlook.com
 (2603:10a6:102:f3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:41:43 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:41:43 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Thread-Topic: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Thread-Index: AQHctkzt2/uGtBr9E0uHhoJ+wJjgi7XfEH0AgBPvoQCAAChpAIAAAgmA
Date: Mon, 27 Apr 2026 13:41:43 +0000
Message-ID: <5d4c3c95-cbe1-4439-8036-b014264ce8c2@solid-run.com>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
 <7bcb68c4-e4bd-4ad9-bb75-99e0845b204c@solid-run.com>
 <ae9l4n8wocbVegcJ@ashevche-desk.local>
In-Reply-To: <ae9l4n8wocbVegcJ@ashevche-desk.local>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|PA4PR04MB7680:EE_|AM3PEPF00009BA1:EE_|PA1PR04MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f228bfa-4466-49bb-d9b7-08dea462bd5b
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 wjecfQu/wLpgFyTWeP4ltt74EmyMfYmRt3fDO4O5FDOuro3TZ4pFKBIMFYgq/+Sxj6i/Y4uuK2AnfHjvDzJJCtKTlGuYF7OJLQMAjFx42PbDmDPvkFg9LhJglRb6PM8zErDgvqgB2FyolqhWVagcxuf8doN7gyBfikhQFasNW1DflO/9mPrhTFjCViXvThb5qojUkQg9bdriulk5Elc8AOYXRDKk16ggbWyDq3jPDNDG2afs9Zw0Dd4gdoynHUHKiMG3MmcUdOrxZHO9Nt/CwFLEbnYiY8qaZI9l6MhDfiJXq/iGvjM/n88jmR6OUAoNnVyo3HHdLADSZD6MhQ7BiGLxCE5pMbbOaYP6avdaYkU4hoNy5W4lcrecHNTDGD6ULmpnMRzAC4gk5Mbtt6vGuHCVYrTNkr8S0SaiuCxT+suNjmqZwkKYZE4+5Vnnhw3dpJP8/iqNdCj2KorAjc61Fr/iJRzqnX8Z4SPiAgP8GZDIS0NEYaIFQicpa8YH9neR7oxOH0hnZe6i67wT1/XQgx6tSAG9/bkesxKdRWbvWP5xYeg1RJJtK9IYnK3nl8a8WTo7w4eLkG2/8Ij0N8dUeHl+sBiEy+nM1cYG0Zqeo+VjTMDNbFKW+P1q9/UQkxYFEwAMCjKCqnUzRzPORpJWe2RN2EAR+GykZ3edMHO3FktkC3l5hQgB2PHHuAMs0EpDlp1n/Ss3po6EQAo8d/ny1RznGvHarBb4b1oVRnbRikuLxnH7ikWM2i5m5zySciUNXo9RVxVhBrD5YP4blIEr68jsrsHnIvVTmA0u7IpmWh4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <96ED63FA6DD8124996168C99A7F7D322@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 tUB1gRzAHsNmgPYQm6S4kQUhzWTOyBhvDoqYncx6yfJOQwA88b1K216HbL2PGFYnMvqzhVmc4VEj8PKVU+oMWS8HqHvFAFcizZ7Ip9gv4w2KtRGp6OZwhuQWEtuirSMky5vw52inwCPqQmcnNBH+ZxOtdgimnQFeMIQKLUnI4cl2aZUVUispvwrCcTZI9in5fMWdJE9Pdkr/5BK8A0FevE7laMteun1f4eHZTjeTvz9t98Jc2KMdpI1NueE0HacYQhOwoCD74LrH3djFiI9fwMLx6hn1XtGrPIdT4YkJdHCKzq4Gsp8b8FFmRLwDWFh/BWgkTgYb0HzgtRcrt7x8Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7680
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 2302646c50a24dd9ab06e3e8d743788e:solidrun,office365_emails,sent,inline:e5f4c0cce52b3aa936fab29a235a2a66
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1a86f97a-c301-4740-346c-08dea462b812
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|14060799003|36860700016|35042699022|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uVG3t6ho4qv4coXLk+HELDww+E+g/LZeYpqcp4csiTPET87OqHRZYCH7QeQ0p8S9h1k/XNlTni3zCpyjXjbS7+0vYCyAmXCGAlw0OYuvHrQhcBw3qCxp11impOjs9W5dXKqUp8wDaXJD31vyzoVyE5xogh/6v38fxwzdYvmmTC9yOIIIPlX7zsJuXTPPsWkoq40RVPwaJBNH636tIUXx4cf/ZGWTzGImtxX54jt6h8ion6ndxA/2AZCBe/nKqKt8y7QlqrivBgOkfW2tTsj84b0H3/ySCMXjoDBwQBgQu3F7bSdkRP3SNTrLbzDGLGYAZYo1wi6VG8O572o5fiKLtFx3K5rhh00XyuQQ0OztpOvG1pxJP2JS9wwLVAVtyjLTAuo0YGqWV3JaaH2/ks3nzD23+GOvip0TsKiUoFjou49xJMt2NWOYo2tOOr7WSVl+p8hWztpj+CbrdZc62Zk0K5HDYr3fIQhOYCBV807HFjHHsPt/cWzpO2AGDjFBrmAOKjGYKMXbroOj1H7Wl1R6t1b8XjqWPCBH9mewhKsJlLQf9DJioex8o6/hEcK9vdOrT9m5s8Ixy7/dfxQqX4l0wvlA5Ntr7eOAmjGmtsmhu1MUYzj0VVTbYXd6Q4AZfIoQHawah7WCIds39EsyTTE22rQq4n5kFoqrXkaAIzJQRdDMKIB+RcAfUTDbFndAOgXYHqctjw/dIiu/8l251tnUJqWeaU2aZzIPoTYrrWKTAEYdZ9fFWNczozYQy4S/0rsYo0OaENTx83E0VK512uboQA==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(14060799003)(36860700016)(35042699022)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B9kv5NuXBIjDtL/g+PcCPEw0qQ3ipkisDSGUlHIfWwxOn2pmgVH63my8PDiF8yaml3YJ08UX63XefDlieEgHZECWEVerWpuEVkjSNj2wgABmhk7Zto+3H3W6rpVLDDKnOi64tiL+FwLr5n/ePaVBANZX83fj4JsXELAhcw0EjyAsrWs9MaY+32FzKbxWN3O24uc17KgoVVHuz+hlB3udQN2uC6MMK3n/OKn4DXnnpF87CeB48LhpnKT6NymWgDlx/8ZF0Psho9SfINuBNuQVoPnr0HMmXwkBcQg21IweTNS5ScoomKFMI77J3zJ9etG3u6Xtf+7YYr5KgUbE/KXfbvniLG7ySkRvH9HJEu6eQJUfS8GKmNfG61lZNh7fCptG2XSE9Q/HO2QJq11bxcsRnpBAHEg083lhldJpiZrUS56BCesAbFBlarwU72eyMJBi
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:41:52.2996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f228bfa-4466-49bb-d9b7-08dea462bd5b
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10554
X-Rspamd-Queue-Id: 818A9473A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7411-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:dkim,solid-run.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[9]

QW0gMjcuMDQuMjYgdW0gMTU6MzQgc2NocmllYiBBbmR5IFNoZXZjaGVua286DQo+IE9uIE1vbiwg
QXByIDI3LCAyMDI2IGF0IDExOjA5OjQ4QU0gKzAwMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4g
QW0gMTQuMDQuMjYgdW0gMjA6NDMgc2NocmllYiBBbmR5IFNoZXZjaGVua286DQo+Pj4gT24gVHVl
LCBNYXIgMTcsIDIwMjYgYXQgMDk6Mjc6MjZQTSArMDEwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3Rl
Og0KPj4+PiBUaGUgZHJpdmVyIGRvZXMgdHdvIHRoaW5ncyB0aGF0IG5lZWQgdG8gYmUgYWRkcmVz
c2VkOg0KPj4+PiAtIGluY2x1ZGVzIHN1YmplY3QgdG8gcmVtb3ZlIGdwaW8uaA0KPj4+PiAtIGNo
ZWNrcyBmb3IgZXJyb3IgY29kZSBmcm9tIGRldmljZSBwcm9wZXJ0eSBBUElzIHdoZW4gaXQgY2Fu
IGJlIGRvbmUgaW4NCj4+Pj4gICBhIHJvYnVzdCB3YXkNCj4+Pj4NCj4+Pj4gVGhpcyBzZXJpZXMg
YWRkcmVzc2VzIHRoZSBhYm92ZSBhbmQgYWRkcyBhIGNvdXBsZSBvZiBhZGRpdGlvbmFsIHJlZmFj
dG9yaW5nLg0KPj4+IEFueSBjb21tZW50cyBvbiB0aGlzPyBEb2Vzbid0IGxvb2sgbGlrZSBpdCBi
ZWluZyBhcHBsaWVkIHNvIGZhci4uLg0KPj4gRm9yIHVua25vd24gcmVhc29uIHlvdXIgcGF0Y2gt
c2V0IGRpZCBub3QgYXJyaXZlIGluIG15IGluYm94Lg0KPj4gUGVyaGFwcyBpdCB3ZW50IG1pc3Np
bmcgZm9yIG90aGVycywgdG9vPw0KPiBBcmUgeW91IGluIHRoZSBNQUlOVEFJTkVSUyBmb3IgdGhp
cyBwYXJ0IG9mIHRoZSBrZXJuZWw/DQo+IFRoZSBDQU4gTkVUV09SSyBEUklWRVJTIGFuZCBHRU5F
UklDIFBIWSBGUkFNRVdPUksgZG8gbm90IGxpc3QgeW91ciBuYW1lLg0KQ29ycmVjdC4gSSB0b3Vj
aGVkIGNhbiBwaHkgb25jZSByZWxhdGVkIHRvIG11eCBvbmx5Lg0KPiBJZiB5b3UgdGhpbmsgb2Yg
bWFpbCBkZWxpdmVyeSBpbiBnZW5lcmFsLCBpdCdzIGRlbGl2ZXJlZCBhdCBsZWFzdCB0byB0aGUg
TUwNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwMzE3MjAzMDAxLjIxMDg1Njgt
MS1hbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20vDQo+DQo+IFRCSCBJIGRvbid0IGtu
b3cgd2hhdCB0byBhbnN3ZXIgdG8geW91ciBxdWVzdGlvbiBhcyBJIGRvbid0IGtub3cgeW91ciBl
eHBlY3RhdGlvbnMgYW5kDQo+IGhvdyBpdCBzaG91bGQgYmUgZnVsZmlsbGVkIHRha2luZyBpbnRv
IGFjY291bnQgbXkgYWJvdmUgcXVlc3Rpb24uLi4NCg0KQ2hhbmdlbG9nIHYyOg0KLSBDYydlZCB0
byBVbGYgYW5kIEpvc3VhIGR1ZSB0byBhYm92ZQ0KDQpUaGlzIGlzIHdoeSBJIGV4cGVjdGVkIGl0
IGluIG15IGluYm94Lg0KVXN1YWxseSBpbiB0aGlzIHNpdHVhdGlvbiBJIGJsYW1lIG15IHByb3Zp
ZGVyLg0KDQo+DQo+IEJ1dCB0aGFua3MgZm9yIHRoZSByZXZpZXdpbmchIEkgd2lsbCBhZGRyZXNz
IHRoZSBjb21taXQgbWVzc2FnZSBpbiB2My4NCkdyZWF0IQ==

