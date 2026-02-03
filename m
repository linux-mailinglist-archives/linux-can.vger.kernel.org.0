Return-Path: <linux-can+bounces-6473-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEz7F2TygWkMNAMAu9opvQ
	(envelope-from <linux-can+bounces-6473-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:04:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C6D9973
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6901730C1BC5
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4858E34EF07;
	Tue,  3 Feb 2026 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lsoTS7Dg";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lsoTS7Dg"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023090.outbound.protection.outlook.com [52.101.83.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424EF34E744;
	Tue,  3 Feb 2026 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.90
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123729; cv=fail; b=XnR6nK9q36lqakqrygeYvoAfWq8iN2eYSxxyxOKEoCC6ifn8McLv4DB7G4qvaLKVmVmmoQXQc3sequATj5jKRCoK8o27BJeqnl9pGjXR/w7xRgR69ajYKGp6ZAJjE+g0vTkvcHrP6ob/NioLCEPAl1E2zIubQ3xbMWr+5IrPBus=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123729; c=relaxed/simple;
	bh=sjb5eqgiKJnv5oQS0oIqpitPoO+3g2RRM66VyIKvlUc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U9cjslMqg+shFB8ESPjNd5mdWxii+PnLx0aDY4CSloFmIzquypYoe8Jp7ADOH0HafW1iL5e+VJnVJ0Daogyl0QvGpCquM3kzFWDD5Rn8dqRPAgZwoSHNjiNT1LyR4633XIzR6eq63efoTcJnIth574uGi4J1cDIRTZ2iURQeMOM=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lsoTS7Dg; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lsoTS7Dg; arc=fail smtp.client-ip=52.101.83.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WBmwLHwPelMo+Y2ZxggBEWJnW+p7TvoXASNhAJcY1Ta0tqdPTxcoEKdCiHKmvQEPx8bIfPu+ZV+sWsKv3cHRbdGh+sEJyVFnL7CfGtOr3yToOjCHlFpHl6o3NKGK1dO4tNvS6AmExMnlBigILkD1DTtGfsU621+SdEjosHKyOGWu1rMpxFfbuYmSpP21ZQmXBAt9PnfWq8cLDIUBS7izbx7RdppMXIQZCQ0kBjO4h/Vx1g+25pHthPuiMqRJ1T6gZpYw68hk0DIQjgvltwbFhxhz5CJIlh0UJW368vl5ryW/BA2WcDb+GOUv8Evsa3ZB5pCkfGyb43jSJ21+l/nJ1g==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=HWGi0eV/z9B/TupUni/+lzP/BL0xwMhREk4OS4Djx5Nj+GruyixJ8ZgoOUswCPtc8ixcQXkHRFZ7GbULjrjzMX5zdKMa37Dtgs/KXQnf1kx/1hIokT7MZ8dBRf0+3JkXMKvOw7ehO+hc25/3Aj3kNftO2LUOtbcwbzKD2NNqneB6BdwhkChtaar08EsOSLs6hURgP6aZK2DNYkMqKOf2QmObm99pAUygaBun5/M6Xvu0eDilHtU0sc9iQuaQ4/0XOhJIFQw5s+G8U1zpC63gX/YKe0201zCyxbB8Iwil1tiTJhMj+F53gwmKnYxtsT0tATKOAGSKbi4CSK7JddYHcA==
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
 b=lsoTS7DgPgllEjvBCEwxSDUz8DDFaW1HSQ5OzD+nAckt9JjyHA5IhMV4IQqIPFZU5e8R9aNNWu9uluTa2wJotU5pRG7tNiMuJLpB99tb5tVhy2RbYINPv7rhvlUZqmn/t4MOgTtUOk6jRzVerihsmam/ZzWvExsq4BIGDO/4UGI=
Received: from PAZP264CA0245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::18)
 by AM7PR04MB7112.eurprd04.prod.outlook.com (2603:10a6:20b:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:02:04 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:239:cafe::47) by PAZP264CA0245.outlook.office365.com
 (2603:10a6:102:239::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 13:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.0 via
 Frontend Transport; Tue, 3 Feb 2026 13:02:03 +0000
Received: from emails-5023687-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-224.eu-west-1.compute.internal [10.20.6.224])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 7D78A8056D;
	Tue,  3 Feb 2026 13:02:03 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770123723; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=NdZiS8JAO3OrRKCS4MZ0MCwqJeaDxXG2qpaL7FQNmubYPFGwMRgQ01um3eb492GNNt2FV
 Esv3wcyrG5QoU0VKJDc23yuG61EoRrY8rNsC9z9kHzA3kgW+kO+oN4C2WZ4w+L+O5R9ECjT
 y2c3H6dPKDi/wraLPw/Fqm+GnXHATL8=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770123723;
 b=VEx1uCWKNmOZ71sIzYsVqK6ojmLcbR4Jf7iM0MZUk9tVc5iKO5K180N3esP5poCtfFRjQ
 ieq+ofgCT6eHgT+Epxardnwi16qhOvvy/6Zu1KVIPxI/WNlRaFXeL8vyOgw/UqNLayDl9q3
 TMZZVbndmEqlrj1T3bMvFdPgUNynzj0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIzOrZ4X4rUH9X4zXSvLXRZCXmvecsEGcN88QV43aK14+6Hlz+3/4v4zuXpS+9/bo7W3cNb2ikyFRC0c4YePKzytGmzyT/UA9qxWrbGwVguzY/I6jqigi4eR0XhCn/pI0ZAe7B83/JVWC4sVWs/qcsaw+Kul9J/j8Kx3IY0hGq4l7CpIujT0ep03Z6S0lbYf7UdafmGLAKaaE5s402fnc4qYHm/cnsK+hRiHfd6+QVhaYKsGEOpXfdu4KBZZZFmM/uqWdxwEWXqFAw37850pKPyLSraB9p8z/qJYopPkFV6VPXne6kPP0hRCh5YD9bR+6ZgkXyftnl/7P2FyJAzr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=V5vpWjF1XS3z2Xwk79i1n5dk4mecX4Ey7tgnfpMZvt+1XrkplKPSRJJAwWQeeFubH8z4ftFk8YtkrYzgRyFMxXOl8ORrN1vSOUqrewLYoK/js6oTbd2Dja5m8lZyaNZdlyr6ApYc9PRbV5aj3sVheOn+nnM4b7KZj1q4PCcGls7WdB6zXg3kJL+rLYVMI/sJvkmkRNN5bhHz7oM/N/UmVMSvuIaMfNUmmXIHvSfYqlUV/HCQMfBuFgshkTArmuHAVtmy6abpJQyN4FYbGkAZ4cOPDuQxPjOrWW1R4giIFh4GFQQRV4RxsEMZklD9EcvJV9k972Kk8xyMQ3akMEx1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=lsoTS7DgPgllEjvBCEwxSDUz8DDFaW1HSQ5OzD+nAckt9JjyHA5IhMV4IQqIPFZU5e8R9aNNWu9uluTa2wJotU5pRG7tNiMuJLpB99tb5tVhy2RbYINPv7rhvlUZqmn/t4MOgTtUOk6jRzVerihsmam/ZzWvExsq4BIGDO/4UGI=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:50 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:01:50 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Feb 2026 15:01:37 +0200
Subject: [PATCH v8 4/7] phy: can-transceiver: drop temporary helper getting
 optional mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-rz-sdio-mux-v8-4-024ea405863e@solid-run.com>
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
	PAXPR04MB8749:EE_|AS5PR04MB10041:EE_|AM4PEPF00025F99:EE_|AM7PR04MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 3427bce1-a711-4394-bd30-08de63246d63
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Z1hySmZhZ0djMUJsbGVHd201K2UrNGxDbWtrN1NoVStYNVVaOFpQYjIvMk53?=
 =?utf-8?B?czUvT3RoSFNOSmZXYjhRMkhscFJ4c1N1YVd0Y1FjSkxoTkpCYVptSjZEeFlx?=
 =?utf-8?B?dHFFTzNJYlU3Y3BtbFZGeUs0QnhsUXV3SHFKWjFXUkF4YVZTSHRETWtQaktD?=
 =?utf-8?B?dGd3SmZENjFNcEwwZVo0MklIcE9YYTN6UGdHMi9BSVJCbFc3dHRWNk5rT3hp?=
 =?utf-8?B?UUFWOGhpdGJabEQwbTRySGM1eUlsQktxM3JrUUhwL1JhdGlTaktvQWkrTld0?=
 =?utf-8?B?bUNGS1llZWN1M3ZjVzhURGVmNS9WN2lQSWJaSU5ybDFlK0dNMENETDlVSEha?=
 =?utf-8?B?SGtXY2tNQzN6bEo4VHdtNENJUXBRUzErKzQ2dDBUVGdFM3krT3p5ZXlNY3V5?=
 =?utf-8?B?dkhWL3Q5MCs1dG5nN3JIdXphdVRsbUV5WFlHYUVWTWZIUzZEcVAySHF0ekFV?=
 =?utf-8?B?TFpYRG1QOEF4WHlBTEF6K1ZsdlByZ1pxdUVhNmJkNkM0MHdOSWg2aE9WNVV1?=
 =?utf-8?B?aS9RakJUSWJmWWtPTmF6R3lXUnJ3NytFQ2ZFQXp3L0lmdjhRUU5tTG1Pc2lL?=
 =?utf-8?B?OEFPb29SZDc0VFVidHlxTDVCd0VCREFQekJVMVdqdGdaZlhlTWFueE9tdFZP?=
 =?utf-8?B?VGFWSEFwMzRKQk5NY05XUDgrWDIyZCtJc2hiZlcwTTVkWHpNR05Mc1BBOFYz?=
 =?utf-8?B?LzV6SE51THg2eHN4THNWaFE0STFOcjBiai9MaXpSWXdSUUJvekNaS0NpU21E?=
 =?utf-8?B?OC8xNjdVVTJBUVJlMFhsMFViVC9JeHFEY2ZEWUI2bW52aXdDeWdGaFBpOGVQ?=
 =?utf-8?B?Qk1jU2s0dHFISG1QaVYrU0hhcnFTNFpMSjBaSXd2T1l6UUl0U283TDFCbnZm?=
 =?utf-8?B?OEliKzNMVldUbEJ4dVRZZGdrNmxqNkYxdnliWU81YVJjdkNmQ3NUb3oxYWdm?=
 =?utf-8?B?WFMzdW5WbWpaYmVtZmx1TEJIamxMZExtVzRZNGszSzY0Ni9IOUtqanZHbG5w?=
 =?utf-8?B?SitFMGdRdkNFN0FINHFUUlM3V1F5V25VQlB5djREMElLOEpMeDc3bjQ5V2R2?=
 =?utf-8?B?MlJCd213TW1xT0c3RFNFUk5ncDl3WE9SeXU5ZEZqRWZiZ1pwSWR5dkZubS9m?=
 =?utf-8?B?alZlLzBEaFZZdkRGVWExZHlFVmk3MzlwOTE0UlFTbVVWK203cTIvTjJtQmVa?=
 =?utf-8?B?WkZ2VGpmOGlvcDFrSzdqQUs3cHQ3VVlHUWhaS1UyOWRMaUEybmlhNFo0NUtj?=
 =?utf-8?B?QThUUjZxM3d1TTY5bHF6M1l0MnN6bXZCdGtaZ0ZMc1ZXMkxCRGYwa0pMSTZ4?=
 =?utf-8?B?VUh0ckRlS0ova25MKzVWT0pSM0pqVEEvMTY0OWpxeXhpa2ZvVGl2VXJGMitN?=
 =?utf-8?B?TGtDcVE0VFZQcTZ0NmlPU3lZeEllTDVYN1FmeHEzeU1xNVcwbGRFNnRyVWxT?=
 =?utf-8?B?bHc2aFJVUVdWVnk2Q0dUQUZYL2lOV09TbSszRmpnTklOTnVRVmlsVlBsd3dj?=
 =?utf-8?B?anhlWDdQSXIzaWZUNUE1WGEydlN1TTl0bTBLNnljQlpVTlpDcTlEYXZJa0VI?=
 =?utf-8?B?OWxuSkR6L1R1TnlxWHlaUElGYWQzOG1ISTBxUE0zd3NQbFA1VE00ZUxxQWJp?=
 =?utf-8?B?WHptUnhiMkRtUlJyenE3My9rcXYwc3ovQ1RWYUpqUFh0dzA5ajdRTlhPWUox?=
 =?utf-8?B?Wll5eGhEZzdTaWFNdU8zOTcwVVU0aHk0amtlU29OdEhXZ0RvaDM5akd6TUpu?=
 =?utf-8?B?eFpEbVBnUi91QjRBOUowakVQOVNJVk55bnhtVytzcTRIWk1WaURhaTBmM0VL?=
 =?utf-8?B?cGp2L2JsbnV0VWtBVlZ6V0tmbGM0bXlIZUwxbkRwQlh1L2xOUmoyTnE1djN4?=
 =?utf-8?B?dXdyeWpGK0RjdWFyMGNLMEt3WnZVMEdSUWFaVUVXYzRvaHlFdjd6MDZheUJk?=
 =?utf-8?B?YkRtdFJscWpFSDJFNXlvRE5TaHVOa1A1dUlVUmxET0VSV3ZqNkpmams2TFhS?=
 =?utf-8?B?WFlkKzdyQUNWelg1QXdLQnF2ODYvNElvbmY3ZGFQcjBXeG8vWWpmRExVMUJN?=
 =?utf-8?B?clBUQ05zV3ZwbVp3aHBrdVc2M1hEMGlWWkxodXU3cVM5aHpVWmRoSVFRS2Rj?=
 =?utf-8?B?WWE3SE5GOFo1WlpMTC9hbE5qdkxhWVNYdTNDYzZTOW5RZ0J2SnkwOHJDL1d4?=
 =?utf-8?Q?1qBGR02HSgKSt82jLJYYV/CGAxmyoTzp2JNWDXDu/IhU?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 0895b3936e48484cb925115ee341bd12:solidrun,office365_emails,sent,inline:325c726d7bb4eee7ea0486ee39a741b0
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4df867e9-0eed-4b0a-85cc-08de63246588
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|7416014|376014|35042699022|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWVwMGh5WmFxQS9Bbm9nQnNnZ2w0d3BzWUtraFBKd3lDUGgwbzVpVnB1NWVU?=
 =?utf-8?B?TE43L29GMGhMUHVpU3EzRm9BS0pCWUNOTDFUa2VqTHRUZjJoN1JFeFoxNnFy?=
 =?utf-8?B?ck1DZlVQNHBlMkJJODB1a3hWaUpDQ3NtTktETytIMFRRZzhOQjVibkRxemM1?=
 =?utf-8?B?TktjSG05RXNZcURWU0hmSVBhV1pQc2RwWU9jMzlsV1ZUczRzdjF2RXR0am5X?=
 =?utf-8?B?NlZPSk51UkI4RHg1SkR4SVlIQ2M4OGN1N1FOSU1pc2dFWW1SNG1xT2w1YjR0?=
 =?utf-8?B?ZGxrLzFvQkRWcG9KT1B0S2ZJQkJaTFk3YWQyVHN4ZXYzMTRCMDBtOTZLRnRG?=
 =?utf-8?B?c3dGVmhpSFRlM21UVXdBNEx0cFliWHc1YXRtamRpVVk0eTNwZ3p2L0JZVjRj?=
 =?utf-8?B?aStiL0VueEtYVVFoWWtYZUx3akdVUVJULy9OWWJkY0JqcWxLUDg1Z0YxdENm?=
 =?utf-8?B?UW5ySDh1YTE4dlJkZnRKcktwU0NCUDFBL3oySTd3VXF3UU1wQmlRalM3SjRy?=
 =?utf-8?B?VzBkdUp4SzRyRUZXYjhGRE9nbFZQUEFTbVJGbFJ2L2lXMG1RKzZzN2ZvbDhB?=
 =?utf-8?B?MDBLa3ZybGVVbXR4MnFiL0tWVnZPdEx3WlpWNUFNYVJraUFTL25aRmUzNmdE?=
 =?utf-8?B?TGhReWdEMm5qNE9pYkhuVjVsdGI1V25zN1VYc0hMMnNxWHc5UmhHZjFzbmFF?=
 =?utf-8?B?L2RNOHBBeUdvVnVqcE5IcFJXbVVSTjNOZ2xMeHFsTTF5dFFmaVhNTkM2QWov?=
 =?utf-8?B?UEZyZk9vSlJHRTZuTm50eG9Db1lkQjB1UnZEYTBEajJnZWw2bVcxZVlWWGdR?=
 =?utf-8?B?K29md0NZSStleHFJd1NSQlJKZE92OHlkZ0NWY3IwRFRmNnpXeFNnWUZuOGJW?=
 =?utf-8?B?cmhYTDVUYnhFS0RsU25pOElhNDdackt6MjJISEM2c1hOTnBoemFxVGlKQjAx?=
 =?utf-8?B?NHZPek5QZXdKenpQd0NOWHc3U3RRSFdCclNYQjZGZnBCcmhzM1NCUUxZQVpy?=
 =?utf-8?B?Z05KaSt1YU0rK2pYbXdVQjM2L1dCOU0yTkc5WUxqcldNcGlib0NtOENCYWNB?=
 =?utf-8?B?N3p2VzIxVGMwRmN3ZzFHbjVudU1vSXZnczNraS9wM0N5amFPLzFOYVEwRmEx?=
 =?utf-8?B?MXBVQ3BvV0hnMWpmQ2RpRHA3aXpTODRIYnFiSnRDRVh2enEwemErQXExOExH?=
 =?utf-8?B?NVF4czBOWVBSU1I3VDUzOTE4YlZNQzRDY0ZwelduTk1tc0hqaXV2bU0xYXFp?=
 =?utf-8?B?NG9uWHFRZkxjNlRLOThCZXNWZFdQUDNiT045ZTFPQVpjWjVVbkdzaXU5WkEr?=
 =?utf-8?B?SW5COW9NSjBPVC9DT1kvUjBHZzNldnk3K00yeHFMM2o2eW40LzdoVHcwei84?=
 =?utf-8?B?ZDJFTFhDY0QyWXFXQWFFcm0rSGpsTGNjdUZ3NkFEY3JMK3dEeW9pdzJoSnRq?=
 =?utf-8?B?R3ovakQ1bGxXbG9TQ3pocCtSYlcyNkRBdkFWL2pMd3Jld3AvM1FoYzRkM09S?=
 =?utf-8?B?dmZyalhVd3BZKzJrd2RMSjdhc3lON3ptYitLN3l3eDNjTWw4T2hUTkFqNmMr?=
 =?utf-8?B?ZVFMNUx3U2h4Z3JraVZWQUpkbGsxUzlBZm9Ublp6eUtlN0I2KytWak9WNmlL?=
 =?utf-8?B?K1NaM3BFWXcxcmhUWFAyeFRia3RHYWxGWXdrc3ZORTdiUmRwU0wvbmYwcTc1?=
 =?utf-8?B?SmRJeVZSYWFXeDI2ejhmK3c1QU41MkVjbHluUER4aktiUTNacUtQM295MkRZ?=
 =?utf-8?B?eGdFcmxFMW9FSHYrbk9rb1UyZzNjUVJ0cnhvSEk2WDBoa3V5b0RWNVVqSksy?=
 =?utf-8?B?QnN3NkNoeVJRUlRKVHBYSmRLRHV2QnNJRThLazNjSmF5ZGd4cmZFcy9HcFpi?=
 =?utf-8?B?TlRrSXJUck1SYTVrWk00d2k5czEvb2hwcWhCb3d0R2psRTE0RHc2bTNhRjZk?=
 =?utf-8?B?ZFpUWS9rRDJteHJpU3Z0Z1lvVUVyTDFGR0pjVmVuc3JJSDFDdmhYdlo4OTdM?=
 =?utf-8?B?Q0F5TGdhOGlPTlZpYU9QVjVoZG5uazZRRnNSOVp4Zm9HQmE2V0tnWkluRi9y?=
 =?utf-8?B?alozYXIzNFRrdUJmV0htYmszN1RmSDB5SlBiSjI3VGN5NEhHMXN2TzlYNmFE?=
 =?utf-8?B?bmdFQVo1c1JOL2xoTDROOXUvZndrMkJPM3pRa3ltU0xaY1VXbHZWVmE4cWFE?=
 =?utf-8?B?ZWp4ZVVKVHJjVVVyVXpyQzVYaEhSY2lQcHMwL3FNSmF0YUFhUWlGSHBKYjhx?=
 =?utf-8?Q?cpY4oHUZAcofkd/skctP1xoivES8FiAuIC5KIGqRNs=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(7416014)(376014)(35042699022)(82310400026)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BdsufJmIhzUXKq3k+KXXc5HgEICFx+j/5VUAjVBpBc2GSGhE5E+LXRQSBD/4kok/tHKgMEw/gUFxhwLS6bla2Qcxq5yui8Rlk8L+uLLVI2a7FcVeJtJEAqkTUKgX4ImWrwpLZyJ3DxlSklD7PNnhPlYNc9/5fc6ejpLkkkHaFNT5rlXVbN/wZ2uPz89YFp1JuPZXzFGZuKLTiklQZ8Wn3yoPSMLoyQR4AyYG3PXkk8SRKvKe0Yv5p1RoPp5veuezKzRlkHkMVsq5Hw5RRVxrjzYlaCFBjwHGzJmU6qmbgBBBZzdbn+TKY0h1wREyuPRSODfBa0DM+Pf2lhd6XMUXOITb9HkDvjiP8dMdKVWK2I3zOhlR4XFORbUy6Ju97RQeIH2vxXZDiUuYmqU0Lk1ksm52wv/HybKnx0UB+c0i50y5DLNxuSANe4dIfRIC9auy
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:02:03.7393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3427bce1-a711-4394-bd30-08de63246d63
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6473-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim,glider.be:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CD1C6D9973
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



