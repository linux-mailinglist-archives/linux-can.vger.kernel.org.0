Return-Path: <linux-can+bounces-7406-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOyXLMBD72kx/gAAu9opvQ
	(envelope-from <linux-can+bounces-7406-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 13:08:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2404717FB
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 13:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70A63022079
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694783B584A;
	Mon, 27 Apr 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="ka1fyl7N";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="ka1fyl7N"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023132.outbound.protection.outlook.com [52.101.83.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B53B47F9;
	Mon, 27 Apr 2026 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.132
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287942; cv=fail; b=s3njxu+j3l2VhilRZADLJy13lRt2uSKG1TNe/0SQwIVDQN1NNINzYs4Fc67u1SuGk4Z1epR5SN3xx8Hm6315j4oOCDqKr8+CtyqPCPxp9OcvsP3mgTpy0ke5SpScOfxusNEKixWrY9B9GyXyQBd2AEDVfdHqsdxvOtGF1G7XyLA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287942; c=relaxed/simple;
	bh=CUvjFOx0LK3hZdGPgle7HZnpKpCeAQ6Pa8CMXAToEKc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+HZVOq/yE3gDhlM+Rr7VONuGNAAhBi/YDz8vI7CAkJcFc0gQPiIM6kbj71dnPIYya6EtRF9qZgOAcefzRLORn0uKQoOpky+XzZsFx+J6/ZRw3Hwb29tHReVRuqcQuLdO0eZH4X0PQU+2jsrq4b6+OKW5yICi+vvSGLzF8Uz71w=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=ka1fyl7N; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=ka1fyl7N; arc=fail smtp.client-ip=52.101.83.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DyyWfbSZT3w+5CB8r9YMJbuKo9SRms6PywexmRws1h6QspzphFOfdLHn8GFv/Tw1IFawePrSyJSLJmMuBZBeU1/E8NBr2Fgt11iMAThk0NpD5xPdl2R2+lFQy4QPZgdKJl/Cn030ZTQDxjK6JsLQh2ZFWbPqCADV2PzxAuhf+kKmW4k9ik4SzChoefkgl73waGKKCke4UgUCWD+MJhVvXmzN7js4XLnin4e/EhfJs+Rj/xlp5zf2wVewbHWieNeqMArR4jsseKKabzTN2qKPs52puHpvn9xtQCYOs2SXRHO6mEmYXfVUmi07VxvbXuPxKgpbeYox0TeZpJQ3BzI8SQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUvjFOx0LK3hZdGPgle7HZnpKpCeAQ6Pa8CMXAToEKc=;
 b=iP6VNM46dBG4egOVYx9AMGVoM09XwthKEeiUcSeafOZPkSU7VLc/7LAO4Jnd/BYK4ON2cvL30RNuJfZX/0U/nJmhCWFd7BX//huF3ozRHBVjJYNIrZLm3yIonemRBvqNcsDDR7CdAVLe9lrG4vh4hVvmkmWaX/Xm9glWkaDuXtXgU4c24Q2KvGlXhHaXgdLe+nQTQ6wkaJML5jHmM6IupPuXE6M/Ii9q3vvwDlBtW5+t5QHP7gfuXF1rnfsYqDtB3QcxWdDzUpd9bXwkeE3gUQfFIJbz1g90YtSBQpM014W39jyY/awFcmXLcF79KPAntRBlmWcjFVtGtplw8E75/g==
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
 bh=CUvjFOx0LK3hZdGPgle7HZnpKpCeAQ6Pa8CMXAToEKc=;
 b=ka1fyl7NsKkWoU3KaZwStyzJpVKjqTMCcwWjoa123JHgMp0V950TmwsLCRcidw47KNaycHc+gMR/dcNEWPfqSbkLAYpVdOwiK62Bk6w5652o4ZIsDxKBN3UHYjrWTxH4x0xq9LAG6R+vjh0tlIWcLy1so0Bu+MKkgSPNShjpR8JxeXmKf58lOE8J9lLmgDS0koUhEDDcayRy4Xf6CjrOU36btzvvivzdqLFvbmbrdK7wFweZnxR5cWi4GsaeoOJ9e7k+dRGGEQiHMX/kAqTKAOFwdWQoCpGLAgEy+M1V+Qz7N/UoE2oeuklnxy1v4LSg3K6WG7KyTtB89c2+4J0R8Q==
Received: from CWLP123CA0002.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::14)
 by VI0PR04MB11614.eurprd04.prod.outlook.com (2603:10a6:800:300::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 11:05:34 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:401:56:cafe::fb) by CWLP123CA0002.outlook.office365.com
 (2603:10a6:401:56::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 11:05:34 +0000
Received: from emails-8907567-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-232.eu-west-1.compute.internal [10.20.6.232])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id C24318055A;
	Mon, 27 Apr 2026 11:05:33 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Mon Apr 27 11:05:24 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4AfPmZy7KZ1R6pz2plkcCSUgtMg17oD6WAgbg5MJ4PZYJ2AP0JOHFA4kb3JmZUbNazN8vcqMfasy0vBSLfQxJsD+QC6AykIKJ5MYiN3buS3nWHTDIRjDBKda878OVJwAoHKMi0jBChlUulVz4ahyHRxiE7/KBw+uDXUOkuAUvMcctdSeC5e4GO03PF2TsVKAqMLPJcVBUBsXqLlHYQp4lSGn6CTWkNumv4rZE4pVCdJq9niab1EOmtS75CpohZ02v50Ym/kQM1vRcom5ZGxo+sMVjS7E57ZfBeiQGwB3LL0uzHX9JCwGjLf8ojo5LOunAtvLXMnve8rP1Xv5O1fuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUvjFOx0LK3hZdGPgle7HZnpKpCeAQ6Pa8CMXAToEKc=;
 b=mw1uyPz7x+g834WbqYtboezA+IAFgF3/N+zlzwoa/MGBRMEM1jhY5uIjG8+rM+5gztsdQaUPL+g6OJc8WP6Cr/7vzTcc6BG4HaoPBvHMwnOzGWyHBnYpAtwJwxRDtVysFK82Lf+RfMiW0kh1p426mmWh35B3FChTaZgyNQ0Hx+fcvpI0F2IodxQHWCTGChMvKv3JouHcU1EJT9z38c/XGXiMMbG6z22p+bbxekZYotOCyGY7AMbWBJ92etgiiKwAl0NkS4yGpWBiDyHd/qRoiEAXTWjCViTRUC/HRvU0iGcTLfG81sX2B/9zCwdoMqqk7jtHe+78sgg76WkzlS0xIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUvjFOx0LK3hZdGPgle7HZnpKpCeAQ6Pa8CMXAToEKc=;
 b=ka1fyl7NsKkWoU3KaZwStyzJpVKjqTMCcwWjoa123JHgMp0V950TmwsLCRcidw47KNaycHc+gMR/dcNEWPfqSbkLAYpVdOwiK62Bk6w5652o4ZIsDxKBN3UHYjrWTxH4x0xq9LAG6R+vjh0tlIWcLy1so0Bu+MKkgSPNShjpR8JxeXmKf58lOE8J9lLmgDS0koUhEDDcayRy4Xf6CjrOU36btzvvivzdqLFvbmbrdK7wFweZnxR5cWi4GsaeoOJ9e7k+dRGGEQiHMX/kAqTKAOFwdWQoCpGLAgEy+M1V+Qz7N/UoE2oeuklnxy1v4LSg3K6WG7KyTtB89c2+4J0R8Q==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by MRWPR04MB12329.eurprd04.prod.outlook.com
 (2603:10a6:501:86::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 11:05:21 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 11:05:21 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 4/4] phy: phy-can-transceiver: Drop unused include
Thread-Topic: [PATCH v2 4/4] phy: phy-can-transceiver: Drop unused include
Thread-Index: AQHctkzuB17tl7ICBE+EGuZzGU0POLXy/t6A
Date: Mon, 27 Apr 2026 11:05:21 +0000
Message-ID: <5b40e1ab-29a5-40f2-a4e6-560f3057633c@solid-run.com>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <20260317203001.2108568-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260317203001.2108568-5-andriy.shevchenko@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|MRWPR04MB12329:EE_|AMS1EPF0000003F:EE_|VI0PR04MB11614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6590ad00-cf7e-43ad-2f3d-08dea44ce777
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 62aOPXfCptzM7u6+FJ8LamFqflV9bgTE4RD03bnh92Sc/4jz9HRg4P5ktxw2q7gu1PJJz3AsNMcJK1xTad5KQ7VrtslZrQYyx6tu32dNLcRmucMOP6N7hPl4sFFJkLXJws2aFAHVhnc9B8jx7fTpBe2/rDq6WsezajFK1zlgMRzjHy2RiFU/Of5JsvIV53lzha4p+Y620O4qPveD75OHcbFo54J+G8dbmV3z0YD71JW5mDhBfGI0bUYXoLQFS5UyysBXArjd/iMRgWa8WT3JseT9WvTanzRdCntvzI1cPl/eH8KY+pV06Fb251eFdnt9IhG9cORHg6Z7N84I2cZ/wJI3azQLgXDH/+uDCdWIGE73kJ3AtEUKx1Ikf7SM+dLu7lpCPoqwkuzRB0vJX3kI9aIsE8R52240Qjd8jQxu5ZRmehgqc55fwLQ3DVVPfeFzDTB2/f9/7Zl+Qiual+LHcvMx6eySlmiNO3fqKlSkEqG+Gfz5hrv2pYRaWX2sEG6lhceWwD/Cw0/FXyRbu3twm+bkQoiu5aDmJlneQ5ox3Xq8EQIU1WI7pv+FhYYZLBAd2l+86ewGGMvKWEEIc/yhwSz6eNOHCYXHV6XjSv8igq1WbGZtgZclqdXmcQ9xFXgMKLX7PsjJNV2zMNTUXsZrHxSW02YNUAeL4xUBVteOnanHfkkDVB+EBIFHON7O9tv+sxavgOUVa8hQGeldyHOmkZyLH1/tb8v0fmoOskpYet0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <522B8BD09D65D84985783F1612F2F22A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 Xrh/slLKAwWp48trfdBgMnHmd5WyRYWSyMgAyx0XxyY9sOsqkYbtjqu52gZiOXpgddtui3/XUZ3pqzFrx32wZNsyxw7Ys5D8btYGG9na/N8JnVbvgMlXtLwJPTH+U8QwRyIcbs3rWl4gLr6lPHXkMOMgPz8ht09GABlSEdwMJncsBmzkGtMa8+/fw6019fGLKhVGYHlRQMf/Zfha5Igro14Yb7z5iNdyu33Z6tOxqu4gxwJgxZub8AIqwKdTLNJ4GpqRqrX8c6o0IozC4LTwMEj84xIwxQ+o/fuaPSQdVYDNjADcIlotdE6RG3MX03CGhWqME1SXfTokBKkiFBG9Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12329
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 7fed17c31d7b4579a240674e980e7dbe:solidrun,office365_emails,sent,inline:e5f4c0cce52b3aa936fab29a235a2a66
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0189a40c-a5e6-41b8-9649-08dea44cdfda
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|36860700016|14060799003|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8CWwRpPn9Zb21aIZ3ASJUsF6pnMDLACMK+j/F984kbMG6TN7DOPDMXZ9W7VP4qHT5dFVPKyk5FGvE0HSiAF/WaAedb16y3HvZIJPe0KxRmO3mylSSbnKeRGIvY9Mdv/JFzgpFHTSsNtza2LTl+79G7Pe+j2ffDkbSrV9+rNywOUpm7OFsQmYz4DlPrQDPTbrml16hPMG6IYIn1l9CwexSR763fDeWkUOmWem2LtfVxx8tFk1Z0Tp2xSmL3rOa461jjZ5FkOjrtuZe6O/VrOVarwyLsssiYJZSbNgFoeTOhZI1tKC7h/HPrlG8i1DT8j7GXycxEDFygy0+gVMWd/8O2XjbkWC/JwyuhyTc8FI250WqMZVigKAVuKxpt0Y9KTSdWlZSbj1Cl+S1Cw+XM9btBXIqQTFjEeCt58jKclEGcZQ2+vqDnn9HJsFBEF+W/6iNhP2232re3qPl/5Hl7T055uH1fQu6yXujCEO8/ICsAzwnZeNeLYs3yL/MeX0Kp+NJhOA1sGFMUoig+FsLHEH5FE6viRd4eEOY6sj+g2XKzs59C3P9TrGmQeBJgXzq+p92bQPkIB2JW/91IQ3/3gPHV52+VawDLQA7HnzTz+JSPjzVIYzek6w8vbmQbJO/7RMnXZT/6vLQM8vrWc5IEM+UW3P2GW9J+Vf0hW7hYAZdSHXiFbw4yWY6M9XATo0N2DLEZHqXB0F8C7rem7jXuopuQ==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700016)(14060799003)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lqaqU4lEdixcI5157XndqZ63zltEo2/mWqTvTVoiikHhQCYDgV4MtP5+cYXufHvrhJYfG27vuLY31fNmZ6PoOA0XFUpc9l4i9Bp+zEQBvbSFuhIGgCyxNtglc0KwUo6O7IjYihrNSJ+OLyLgGMi+CAazLVx78KMmMZjXHJ05Rvpy9FkcVtOLcFfYxKr9ISMsVUNE4rLE2L1sAlk7foO6JdIhmOzDXJ8TenHKMlJ6WJeIyqWakKtXwZgcNed9uPOXVrvPeQWSYNlwhFM6QIdCsQVA0k0+Rb+LsoLQjoST5eNkRPG6VVHsuViBOs2WsOYg0fVIlAoyuv1WGwt4T/KB48X6wzrs2QADoGNT127IzMp6F8dUVVBkYQYeicN8PWANnf02v+V76FmreRcSNsY7Y/GvXTC9rbVf8LDeVcMvVmghBZakUZ3TUP49QrQye+aN
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:05:34.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6590ad00-cf7e-43ad-2f3d-08dea44ce777
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11614
X-Rspamd-Queue-Id: EF2404717FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7406-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,solid-run.com:email,solid-run.com:dkim,solid-run.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[9]

QW0gMTcuMDMuMjYgdW0gMjE6Mjcgc2NocmllYiBBbmR5IFNoZXZjaGVua286DQo+IFRoaXMgZmls
ZSBkb2VzIG5vdCB1c2UgdGhlIHN5bWJvbHMgZnJvbSB0aGUgbGVnYWN5DQo+IDxsaW51eC9ncGlv
Lmg+IGhlYWRlciwgc28gbGV0J3MgZHJvcCBpdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQW5keSBT
aGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9waHkvcGh5LWNhbi10cmFuc2NlaXZlci5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGh5L3BoeS1jYW4tdHJhbnNjZWl2ZXIuYyBiL2RyaXZlcnMvcGh5L3BoeS1jYW4tdHJh
bnNjZWl2ZXIuYw0KPiBpbmRleCAyMWIwNDA2ZDFhMDkuLjhlMjUwMDM5YzE4MyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9waHkvcGh5LWNhbi10cmFuc2NlaXZlci5jDQo+ICsrKyBiL2RyaXZlcnMv
cGh5L3BoeS1jYW4tdHJhbnNjZWl2ZXIuYw0KPiBAQCAtNSwxMiArNSwxMSBAQA0KPiAgICogQ29w
eXJpZ2h0IChDKSAyMDIxIFRleGFzIEluc3RydW1lbnRzIEluY29ycG9yYXRlZCAtIGh0dHBzOi8v
d3d3LnRpLmNvbQ0KPiAgICoNCj4gICAqLw0KPiArI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3Vt
ZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9waHkvcGh5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
cGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcHJvcGVydHkuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9ncGlvLmg+DQo+IC0j
aW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L211eC9j
b25zdW1lci5oPg0KPiAgDQo+ICBzdHJ1Y3QgY2FuX3RyYW5zY2VpdmVyX2RhdGEgew0KUmV2aWV3
ZWQtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg==

