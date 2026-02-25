Return-Path: <linux-can+bounces-6621-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PfZAUbfnmmCXgQAu9opvQ
	(envelope-from <linux-can+bounces-6621-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:38:46 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C6196A38
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C046630FC156
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784439525D;
	Wed, 25 Feb 2026 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="MDGvtGHI";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="MDGvtGHI"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023123.outbound.protection.outlook.com [40.107.162.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB0362130;
	Wed, 25 Feb 2026 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.123
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019292; cv=fail; b=KWKhgInKo2yDf21/o1hxRDrwj9URw7TrpnZJa+GfRTQeLS4l+XqBfUbF2KTjsM+1Cacraid2Jbq70xnQngJP5TsTVboqHAw47i0kMgMMeB/6dt5pYrB+h+X4KdKq6Ht1hOE2fBtJR+jaD1ylCGRRxQroSrVk0SUndiE2CXIKD4c=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019292; c=relaxed/simple;
	bh=vbbBOdQUjTNxLK15Ec4u8vqpFcFMesnsAjpqirLglxc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CnUByRIJ6EKhRTlnJcZxAO6h5rI+OZ6KkQchgltzETsKP9lox/7YvvM2LBY1gTnv19kizMvSFn+O2bSdR6phZUgAFF++7wDSePLhtBH9W5NG+g0594Mv17Pi4713Nuv6p41GqKtx1zX0C5GaFvztJJQeBHmvT5M70gW3Vkwx5Ao=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=MDGvtGHI; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=MDGvtGHI; arc=fail smtp.client-ip=40.107.162.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eHIi6RXNThwPMvIEgseHfxhfEA6jVccWnOF77LBgu3ziZGaMjhq4dwa9cSgj89Nk8E5IQkoHGRgF3SZBBX72AD5c9FmbYdU7FY6WfxcQQKsb2VjzrzgI9Hgj6KNUQKjApMV7Aazs+VjAHhKhDdUD5DrLqB7cJOV4Q5FnF1UgwUXDWKb3yp/GPF/Lh9t+6XvcH6da+/1sNYPeB35JVoLU3P71smY0zIIgKk1T/Xwi2fZ6JSpid4SZJDseKk2VcfXotU6vX3uW7lS8oiBHJboJwXxqIYJr38PTwSqDB+wV7tvgdG3kITjyLMWGR7XUzS0AAOYgMbWAgW0fUnsi1qJNDw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKF7I9zOLyZw1miNJ21IT8te9ajBviLlwLCKyU3RJiw=;
 b=drIVyAudhkPl9tnz3TgDUbCPlpHup2psgzyXFOPAaOgv9svdNvB7HmfGMEogeMD/VwVv9C4GNs8obcMItnbWvZexnEJoIcX8bJH8qhLek4Bvx0pdLtZYbUq9ksEE+jGDSYuYY8JAAI7e42NgoNcluiDyJW8wijrkwbwWw7yA5ZmtB9MEAAZj4IfOJDRWsCQr8Fkwm9/e7UqVXd1HpuRnCyLwXsZV8twoyQVEwePBCm+4Z9kF2RQMWQYpZxT20yaHQwTjh4Hvyhi4V+6HxDo2f41oD4Q0FH+KUeltdrJdyMRcl4O6vywfMAO+sUy+0vAgbZIy2PqLSS7kUEgLhTMXSQ==
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
 b=MDGvtGHI5wI3FI5XcKPGhR9afzrdAstpANCjawjA67u1Z9/XcmAvlXNdAUQ80RuWzXGp54OGFbsWZa/sz+eZXf26QBBZ2Sy0OoUnPJCCAvDkPFPoiTrt1Dr4GieZV6G7Fm1X3gjNXZ68bbmCNkFQJIpvy08qFaWbwVLZVwgDC5I=
Received: from DU2P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::15)
 by DU4PR04MB11337.eurprd04.prod.outlook.com (2603:10a6:10:5ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 11:34:45 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::57) by DU2P250CA0010.outlook.office365.com
 (2603:10a6:10:231::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 11:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 11:34:44 +0000
Received: from emails-8480253-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-66.eu-west-1.compute.internal [10.20.5.66])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id A4E7D80048;
	Wed, 25 Feb 2026 11:34:44 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:39 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wpbb6Z+FQJrUhk48Ieot/8aOk5rBaWpzUd3q31JW1oHZgnED11pKJoL6HXA8J70J/Cs8TyIaaURo4BML2MiddYp4IipQ5bi1ZuE6xf37OqE2Hf8KHlqLn4ani2aFFnQ5Gq9i72YR2BsykzLJjWn8LomlF8WF6AlbrnjhTPa7GVmdOyvTjoxTTgBb+I6aTjTo1yeiGZ++e1sS50Y6STqxr3EcK9HDPzRhHLlJaNzjeSdlx93af/2g9VyDOV9yVL41HvwmHIQpSUaD53MTKBAn5TKgltLZdxeeAnPZBq42Vi1EcyPCYi0scfeJ950Eky7XXbZPf71m2ybq1k5kbVtcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKF7I9zOLyZw1miNJ21IT8te9ajBviLlwLCKyU3RJiw=;
 b=CTDv9l4VWma1chtkY+TRRv9VVOZQZhlI+20gavJ3S6AewszJtqebRsSdUuvrjKAFSv7YiHYMkRni5ndUUjN3K+hiJ0jntntyPHgSwsgo7BU82aUozMjCd+WzCDE+MYrg4WK6SRR51URayoiqSkt8scrI3+droq5oL6FHZo0qduvjVgWJtxDbM73rN0fV1oq4axDDyrqKxzKyQ7c3IrdZQ2yHfCTVQWlmV9n+Gwp4MU2kP0233IYHl9aMxSp6NHW/Xzi4nWXIfjSaBAzQN4lm9Hvkq6LSfd2aii0VuVTxCe61i6mwMpFtZodswXH3f7cPLUNXVNV8UVXe5LQfgEiGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKF7I9zOLyZw1miNJ21IT8te9ajBviLlwLCKyU3RJiw=;
 b=MDGvtGHI5wI3FI5XcKPGhR9afzrdAstpANCjawjA67u1Z9/XcmAvlXNdAUQ80RuWzXGp54OGFbsWZa/sz+eZXf26QBBZ2Sy0OoUnPJCCAvDkPFPoiTrt1Dr4GieZV6G7Fm1X3gjNXZ68bbmCNkFQJIpvy08qFaWbwVLZVwgDC5I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 11:34:33 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:33 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 25 Feb 2026 13:34:16 +0200
Subject: [PATCH v10 2/9] phy: renesas: rcar-gen3-usb2: rename local mux
 helper to avoid conflict
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-rz-sdio-mux-v10-2-1ee44f2ea112@solid-run.com>
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
	PAXPR04MB8749:EE_|AM8PR04MB7267:EE_|DU2PEPF00028CFF:EE_|DU4PR04MB11337:EE_
X-MS-Office365-Filtering-Correlation-Id: c7819376-b354-4220-b252-08de7461dfc2
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 B2CgMxJYmaWd6r6TG2RPDHGEUK2mqbu0w4UuYHvx3NLsQZ+kg0HhIOcTG+u0axXtvYB/Qyyt0E8nB7GgbIVFhs1/rZiPB2QsMpqJKMkV2ZupWXx20Y1oR7TgI6rYsVp88c6Oqeqha1YoXLeUjPwbbC2y/ybCpOxBWshYj0doUGnE/9+y18XkgK+90+t0gWHMXlWn4HiiGKeYHhSpcyvSPZDprU8b3lRWtFXiowMj/vOTJSOCoOAXoZeSqkXg4H2HomljamMdMB9x04GabksmhParS9Uao6o3tckSpcxELqG5oIiCldU8QT1x7v1L0N6IUsM1ZwLH1peYZx5EWBqt8pIM36fyfp8og38hy0O/uYi3Ed5BS7l1jU2jnzi4XH5n1xEBEnbwNqzOV2mRGc+q4ugDoXQjBDbnXc8Ls6sWtfHQA9a55oR4Ivzv/VsFK3SlwBLHdaW02ECbTnAIrbrIflfZ9ZD5eYVOE/uZ3Cu3kHZxY9VudxOLQYNjH63swwtXM2+biNp05b2dGXkSSvRNbxWQ05rQLN9qQt9DLJqZMMoWOH+DFja1p4XyIC2GwiD4leaeFPZlxvnfr7XH8IQns6rH+ZvffrHv+CeVDFSWdLNRkxa/CzDWG3XbhMx6C0AS/NWC4qVjBypPqOmEGroU3IogPJBsMiWrGe2n6/nQ9+a3YTab8rlKw/RWWHGFvAWXrUlPqaxjsPJmWwA2FYBKgbVI9riVip0cKhF6qaOqDYyta++cUxhe3zl55jLClb+6DJKLusaW41/PyPwDd9MSBILM2ohvUKHiShvi8Um18MQeyjDrRjKNx29feZfx9qv/
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 3ce681fb309a46f090b3f8f3cf703569:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	16e06aef-79c2-4d64-deae-08de7461d905
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|14060799003|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	tQsJgTxOO/BQ6jgiUAVe22lfTOilyKKqA6tkxtoX1gO9Kp+unKN547eyiS9cmA16TCuSxZIWL4lRJpLgK315Y/hd3NfUzWp8eAZzgHChHwXMzktYJfonacabA130CJnc5/strtsJhf7TPDA0d5WAA6qsWbyyJk+Ea5XvdK6slDulcLe81khc0RoFIDVxbuemeV9/51yf4d3da/4uxhPshUIG5zv1nwqys9eeG584lUFv2uAQ86R9KrwNhdlIJl/n1hZgSxb/B4ZEFO7M1hRh7Kt34hD5FkESDCfjcbn/cjRAAmr45iFgaHv/CgTiLNo7Z9bP4V9HuGkWc80FTgb5xf6o7qMyDVLyb95THytEIPM2S4Utrwxyn2nIHE7OKvDgdK6jHVjkHLJIkCvWwVU8+JeoQO1K86lh/hFqF/46zj4s7LkuF3ZiJAHP76K+oEHW9d0wrCBtqmb2G9Y3OAOVyGIjokghyT0BS5F6R87muLGfYMXKNA0WGXenHgASpVUEXjYafQxm3vTrzVicT3LsrpISxdL3EFzna7lfdtK0+olHMXeXqxg3D2Ki7B1Nalr58wQTHVbYDQePPjynfKw6/cat2jI1PpYlOgcsFQJQPmqp2844uHH3XVLjiJhRanGwoC03sNhsGE24HvAO4hh7AvEuFhBte3vDl8fF9TYtiPtVEpM/qjqjgGOWz01sQ2Swngfk9d1VrCkroM5sEEDepnAAdtYs6r7CYLYimaUwQl+kkx5GoNchZxq5PuCmav+D9KpC5r3gwI2x7YqMClESp1FLAxLGd6ezg8acH0cmIOu/UaPDQqMXhLg9rVHJmnejeRVBhDAvGUEOCJn8QjjPP5Qk1cvCKdTDEG8zoYybVso=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(14060799003)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6l++/T3GD/Y0d9IE1ViIrifIh9RNOW2Ev4HKr8mzJ6XT3n0ILHr1aUY0HJDFdQ6IaDXSdCLlIiecW08ZnLnYSpngAcTgEOEA63nrk9O+ntL3YxiOU8eHkdhCMsbfeHNiCdIs5/TotdD/LYbt1hMQQL+uEBCRTgtGKIcGj53hIRP03fDIy/lYEL7jk1TanTnXrAQj8bf2MaUN2tga/hyvgnmc/78BwJMYSAlmCoM9a93iXIFS7HKoxkFu0J8Ydtu9zD4oGq0HAOCok3Relc7qcu6nc+cveFsaHTNXnKmnaleTkzD7rs01YAxBKhUy631bo4BihxBNvrS3ZZdH+WjKrz11rgc/9SjdNl0TIcNkgk3cUl5MlF3hqNdR+cEIvwN8vdk0V2v2XrAtwj2TWK9WXRMumidkJjxWaO15yIGvsEyj9dj5eE8IGVq0quzL6fxC
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:34:44.7488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7819376-b354-4220-b252-08de7461dfc2
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11337
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6621-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 679C6196A38
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


