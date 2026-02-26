Return-Path: <linux-can+bounces-6645-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BcyBaFKoGnJhwQAu9opvQ
	(envelope-from <linux-can+bounces-6645-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:29:05 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF4A1A6936
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E7023159939
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D2833A9ED;
	Thu, 26 Feb 2026 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="mWZTbaRN";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="mWZTbaRN"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023116.outbound.protection.outlook.com [40.107.162.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3532A3D1;
	Thu, 26 Feb 2026 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112121; cv=fail; b=KXjVn85vsKSYaKN27UCNg7RC33d76N39aDcP0GV+YB8zcIX8YhKHjDS1FuMizQU7W0QoQpD0kra5uDApXkDGLeVO2/9SVu50sQA0WqvHUtnYMVaTM9RNv+rB9WxEeEe2MUM/ZjBNA14t2UBYZxp4OdhqVlUiFGJKxhstDsuYNaE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112121; c=relaxed/simple;
	bh=lwo2N1VQxHbYFKvBY4PCNgIqvgtASSI8WB/NcznABv0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jwfFVUi16/8CGVEcZDl6LSrdZkCtRDLPPu9Hynxm4i74vLL/QBnGuKy2ENzH3Og6gTDQp03b8xrwird8ELRyzmD31wnYRC/U96aMpxxipGpJUriPywzili7XcDMe4Is+6X5JxmzCIhQoIP/9xwxv6XGENxCxqa1j35poSaSxxJ8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=mWZTbaRN; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=mWZTbaRN; arc=fail smtp.client-ip=40.107.162.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=t8DbK0h9Zp5YXhhTf1OIiqy3qRCCigLoF8gFxrcqIIuhbf9oRtg+J1fOoXZEvO/p5XnII9ylG+QkDUKNrPtjsH8+H3E1RIBclVZTdMwPMOwzCZBtKScaSI7PHB2zJee9ODIyTQJdsBH483X6uTb31QUeyUSOVG+VrDFiyzjFuuKA+ShOGb78iHsRTUoctLzXplp83ZsbhGZ1YNZAsuqAvXcL0MWebYTfS9kHgEwmlIyVOrG//2DSdhkVbG23Gj/TcIcX/IJRnaai5NG/c3JjmcStnbG61cpwuo/6nUrQ2UI/AwhTXqRMENlHdGQp7cYhECDZDDz6P0j7fNW5ATHoKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb98mak/6IJKgwYIjXGYzN1dXVw8RJEITJbKeASP2rE=;
 b=Bv8UH+u1sNsbc537BYH2Xqp1e7K1mJv+nLAsA5clQAiPUI8nN8H59G6dRobldtcENNe1TKKb40U7AqIjF1h/fPAzNch4i3ewEF2FQ8KsZ0rgys9STwIMp34WUG9jMJWJ4A6mpKrxpWkHbGly++nYXzYw8HqcPtVUOlB4TUQWEyzUyJr+UBHHg8siYXc3wmNbtcqjgcbG+Sf1YqOs8q+Rj1gHAr+04SPsisZu9Nq0C2mxo9gedxNBdDoaqehYZPbL17MBX6FwtTlpEuy533v5+iorV2BxClz3kJZbQfjZX7vva+9GzjXitcbbK50HBaK8Fy4rySMpIA4gfEQME8JpTA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb98mak/6IJKgwYIjXGYzN1dXVw8RJEITJbKeASP2rE=;
 b=mWZTbaRNW6WP1cnGl27NW1NIhjd35wMCIeQLrNdiaSVDPbe37LgCRBeZk4ogw5IvjxnO+XfECuz/bu8+pMehyGC6rwo2kbqANQBx96xwqm56t3mRHTDnZXuqG/89GIub0nvUuAnCz2MsPgwSLPbOVl8irsuGUZCHdFLgFstCqh8=
Received: from DB3PR06CA0035.eurprd06.prod.outlook.com (2603:10a6:8:1::48) by
 VI0PR04MB10952.eurprd04.prod.outlook.com (2603:10a6:800:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:21:56 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::da) by DB3PR06CA0035.outlook.office365.com
 (2603:10a6:8:1::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 13:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:55 +0000
Received: from emails-5074848-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id C122880737;
	Thu, 26 Feb 2026 13:21:55 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:48 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+b0XKPj8oJuUgb7eDtCpOsgtO5EazQ1qi5pBnoS8uOsBRJD927kgOqOXYcVJHbhwqMNuR8QejWDg5aRWvTOBM0IonsbMTx+5tx58CmE0agf4CL+9van2T+MIoX4vhrVsHFTKWAxBLJYktsNK2mtUTZGL+n2LVGcdjB5/bAyAY2eiJ1VzZE7zYwixg5mp79zUGiBvbfQ7eQRrod2TreczKGjO++hYMGW0O6qn+zopmJPAVdY7zTMw/cewx0Svw5B3Wh5uKNEtYBCVWCBtDDh6tdJp7DYgLy+XyU2KIt9vatnA7ELxxl/snIYQLAQBbH1gWk9Z/zsqfBYNuPcodeJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb98mak/6IJKgwYIjXGYzN1dXVw8RJEITJbKeASP2rE=;
 b=Uwpk26weYv4CyY6zyqUyeJShXQn/I39ijEKtBBeD1TMNLVCArbSHYuw/dV297yuyUVwiDZJzdzGtyf1GJKKaSelLaVSYSPWx6qH/zdh/0Zj/kOdmGxsdnAHcg9pFQ5xXG2jYj234+gfBpkZStf0hnbam5ccRVz/OxtlxOF71AEKXoKPxG00Ty6WNVKvrXvcewLgv0AEmENcUFKuTNIMDto+1z4mhF8L6jb0u9vETCz3JbeZRWegBcfbWj4HZ6bLGQNYqMT0uDLDxTYVZ8NjNOrrIkMBPVXd8DWziYm7MLSekdz2ttwhB5uA8UXlQUE3wX9WWOrP0hg62htDUrsZq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb98mak/6IJKgwYIjXGYzN1dXVw8RJEITJbKeASP2rE=;
 b=mWZTbaRNW6WP1cnGl27NW1NIhjd35wMCIeQLrNdiaSVDPbe37LgCRBeZk4ogw5IvjxnO+XfECuz/bu8+pMehyGC6rwo2kbqANQBx96xwqm56t3mRHTDnZXuqG/89GIub0nvUuAnCz2MsPgwSLPbOVl8irsuGUZCHdFLgFstCqh8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by GVXPR04MB10450.eurprd04.prod.outlook.com (2603:10a6:150:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:21:45 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:45 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 26 Feb 2026 15:21:17 +0200
Subject: [PATCH v11 9/9] mmc: host: renesas_sdhi_core: support selecting an
 optional mux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-rz-sdio-mux-v11-9-c2a350f9bbd3@solid-run.com>
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
	AM9PR04MB8747:EE_|GVXPR04MB10450:EE_|DB1PEPF000509F7:EE_|VI0PR04MB10952:EE_
X-MS-Office365-Filtering-Correlation-Id: f47a6e66-86a7-4a14-9ac4-08de753a0368
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 mTyaFzrwJnjoGuZHpOYleOSA4heYdk3WP4nwa1rYd6n750m/HRVoymDPkR/qbnfLy0g5rBuKuUvMGSufDvOljlrmUdeJiac1hcujUbCkcRBuGZOOzVp0VmXgsKIUXYc6EipxNKXvYlElrQYKzIA2YjcJOq+GSEsrU4FZtKAWhDg6Ccx80JB58PEG9dyTN2FcPMpTQKSWtY/KNrAQKVy5QYsTppvgmJ9XBL79ZvM/MmKCV2PZQEDjBNB0Na+O3GVDXrlMoNJu/xFhlae/ddQbBdB8StDbKMyYIRJSEBh0ljyoZnBpqK4MrMFrn/Y6EaJx6pztp6qcBXnwEtxU7yJQz14IsFFwjxkMhHEgBz+UFOseJfcDiie8WZvIW5UdNZxBHAEaAnGqS6UQ7CN+G3WS8Aw2jFWsyVeq0zVV24X7imdxg8h0oqzvO6/OBZlF7KJi18djWbJkqLQ1od/x2SH5CDhqEMd5jXXH5S5SGv/x9TK3NAXrsfripA6Gp/l2hV88Zs6hirQPL/TWD0ZqCgqp+BqW6hCay4TCT646cPRSfQY8dhnXpgApXMKY1wfEDi6hcboRbj2mknwSTT5Dq2LGb5vhgtwrdiCMY/jWd7C1/o/xXLfsHOq4fm3dgzBeDuQU34JFycumxYHbXTrOOWFQAaoBVgMl1s8UQlXmPhtw1XZ0i5OMZhGqAD0VUAblRm50Ut0hEnoVJSWbgZQXFsBGzL/IViDsnnGulxD0Es18lzzXmSS/wRo/6PG5ASahvgFg0qrkh++CjVCGqThVdYaZYIPSkKfdGlYwU+ARQm3UYiBKsXuyaYke2thGOu/Tr0XA
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10450
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 88f8956af3f6465cb19ccd5d7d098d77:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d78858e8-b759-4ebb-b2f8-08de7539fd09
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|376014|7416014|82310400026|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	cxujCebwNZEyKxkgppRiYZk8wnlGYYDOrr2IJMfe8eEitkJCgHhoTVShkaYboXQE/Zyn6A2ZrPkhYFhsQb4usx3HaJ0OI7G7EjaDyOB2S8QUBpINPm5iS3L3Zfh+lVEhxJZW/SA9T7oYWiV+zs/3pXQwgXSC3PPP+fdK3EWEY7u8Vvw67ruFh/APX48kZPMf1fM3g4hu80QptGh7DIsEBTCz1po78GrClz0VdaITOmK9FpkUocou/veGKwQD1uq9kZsrI+gW+FIYsoPL4+bbPjeuSn9Nt337XHFEZrt+4mYpm/vcpD9xvbzvRtXv/rYNncmtWJ5tItdJM1mnJNR5+ds0I55ziu478xjd/yP7wZ/9mvgkDm+w5mlEtkRCb1HYU0I71wSSnkOKNrR956BsyMj+tMu+7wywJ0GUphHZCwEKaHhYBKrsMfyva2kdZ50fPujXarEqF0Cnr0S1BEny/BbymIhxuauwJb+hkMUh1MsWeFh3XKNdBTtywnb0s8V7EVA9rscgZECcE1Mq9Mc08V8ImeOUdk/5YB+bEUjGyxhR/RoRkdjbAzYMqjJOieh91jtQRR7EXv5qr5DbrsdSaa15feXS7221iUCg/b2QarrfSTsocdni1OxIcKAoV7Mxr8qcPaX0hO410R7/ZaP/4ysUtNre/DruVA/Dydw9LBdG9H56xhGKCqN+OnrS5G4N2+VrIC5ISe89YXBSZCcNjk/yHYttLtsZltu8kndy/pAb7rF4lANFhnyxwdCocbCG17k0cUmaY0M1JaWej/yVzQiVzOZCi6wRsMWHMeRVV3gaBbiKCk80okLZpgNa4QDmoR4v2k6VLxB4p+evUsInQfIg3CYlJwAkjVKhozhZtl8=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(376014)(7416014)(82310400026)(14060799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VU5RYOwYEuPDrlo1fGBEIBZSmf7lK2VEsq8/XJJYqqPT6c6Y4ITUbMYuekXYPxoLPIyma+v59URak9yVP36YPeEwBt6+MfLUl5y2GzzAcpoBizdr/+2Unv3lxgmSQUdP0ZXe1AbTBYI7O29g9RrJWczlJZ0chGtrdimflArU5N5OyS0sUGjl7+z35Y+OCBmFp0wG3NRnFzey0ESBhWEeRJLqwLnLDAaI+k0X8YH08F9tb1zPS+Obwj9Xx5sdDYT9xDOHMP6kp9xVW3OSuFT2oElRwM8zmbjzdpk8AL8SPSQSCo/g1G0/3mrgyo3eJKJQ32WBKb9Phc2DLyDBTi0Z+VwHjYGjvuOLR2Vjbn9Vl6x1kDM7kiZLQ3j46uinMHo2yQOLvuqx2H9QulGMlQoiO7RA2Li9glKvgL2iC9614yWEGCcrgIuUfEo5fIANP3nF
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:55.8511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47a6e66-86a7-4a14-9ac4-08de753a0368
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10952
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
	TAGGED_FROM(0.00)[bounces-6645-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email];
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
X-Rspamd-Queue-Id: 8DF4A1A6936
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


