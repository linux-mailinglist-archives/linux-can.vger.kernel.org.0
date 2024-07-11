Return-Path: <linux-can+bounces-963-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDA692EEB9
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F20A1C21F72
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15216DEB9;
	Thu, 11 Jul 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F7LCceiW"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013064.outbound.protection.outlook.com [52.101.67.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B716E87D;
	Thu, 11 Jul 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722023; cv=fail; b=TvTS2DDyY9uG9xRfnMsd8X5nHqIsnHaF1CwmJXTVrvrPakAi8YqmKNGgKlTvbFF47AIkvY06LMkgwf+Tua6rFQMbz6BFNY/RjEO/WQdvgMhKfnkSB0U9p4KhIn0qFWvYX6jzIEiQwoPXVnkH74NfTjgXbveUc1/wnViFa7qALGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722023; c=relaxed/simple;
	bh=fSK6/khQWHcHhYwL/7q0VT7xBau0KJTduHTplySxMfw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DFVdBMu0nAcQXMT+ZmrqdT7inAsAFa6obUjc2goZVTSs/S11QTsKKo07CTf9Efw23vLacXO3cLsRYaCb8fBi/Y3lQPMM7eqE9DaU3tK5CX7QRi0lR17OtrcTBsBn/qo4HrNFHYtTDXqwDbPLI8husaDOK0Z/KRKl9b4n0Ts9pwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F7LCceiW; arc=fail smtp.client-ip=52.101.67.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWjv79Kw6ppK4ESGrrF70NCJmHu1svugScju1ekEYx147h3FbNAP+cvA53i659V7Zy0yzSv3ArY9AYrKwYNoGkhcYXBaaIZjzg9oCp9o5QL9WOrGODBmryeBFKH0PuJnpAqiJrLLvfPxjK2STH/zvcOgW8OJjk/zSH/EtS+Gg6ztC5uHwuXzHst+IDfnoz7xeepM+RsTTpCvyAGK/d6ElXxoSSEFxcI/CCiv7JHJVAxkbrc38Rdcmc6VmVq8JCQwy4hfITs3uGRot/93iXpRjzhhWnF3CudfNmgAA+9hRHJr1GU3c4O2Q+5q9qNZw97wNLCeJYWI3cicjc5PEpvWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYIJQPTw6Y7jhRozwFeoTj8X4A9n/DLtphwYYcnPji4=;
 b=qymngHXWeCqzCR4rjhirg6S+ArjO5QBpzGeFbLQ7rn/KKc6H8c8NtdD0B+O1dp6iBEnLj3Ytc8t0nUfs4mQtuwESzkTWeranPeOyGz6e3K/QTPZCEiQHpVwGbM+7vo93SRayoj++6MIGo/sSNxuhKHBtQQPALqn+g4YAVfhJ0iUmah1fmvplIvlw10GqHmriOZ6gPjHcHx5o3vMmPr0cKiMmKM2uZdwnbF4JK06u2wxgYPtJks7plV0JVqQ3bi09L9ay3xtZLltUzubTLa+3WyNW0Dozb1/2iG7nZvc6k3OvmopOQuMyO41AufPmPwtvjP9alzg1ASKIDzgYcrTNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYIJQPTw6Y7jhRozwFeoTj8X4A9n/DLtphwYYcnPji4=;
 b=F7LCceiWuBzSxU/qpgFEaxhHiRCbmoEdNmw0wqe8ZievnUYgqj/S4393wPjLU7xar5UHKJqTjCAT9znUoZYGui60JudZrT6oGEpg68wmHgvoaQXc73hE+3IcJP4H8ggOJt30topIAyKvqPj1CUglV37ekC3Di5XC3+sXGfosjGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 18:20:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:20:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] can: fsl,flexcan: add fsl,s32v234-flexcan and imx95
 wakeup
Date: Thu, 11 Jul 2024 14:19:59 -0400
Message-Id: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8ikGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNL3bSc1IrkxDzdZHPT5LTUNKPE5CRLJaDqgqLUtMwKsEnRsbW1AFE
 X7hBZAAAA
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>, 
 Dan Nica <dan.nica@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 Li Yang <leoyang.li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 Leonard Crestez <cdleonard@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720722012; l=1349;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fSK6/khQWHcHhYwL/7q0VT7xBau0KJTduHTplySxMfw=;
 b=PT656OmZrqVRcyD7FLW3uZdkZlWinLJ3eppqtaGBh/pXWdSCmkd5LFwhCV4XnqiQr0BEQH9dB
 ujazgjkA3DwC1G7R9Y+xZJbaJmAMjgsDKq7k/gjwnOhMKUZ/tEg0qlX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0134.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5d23c6-5ef1-47d2-73da-08dca1d61de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUgveVhSeisyYU42UnhNcXVaUXZuUXo1N0VwNklqQkpPUUNtTDh2YTFUZ3BU?=
 =?utf-8?B?UEdEQVZ5VWp2bjkyejU0NjJDa3RueENXcGpSK0tCbzNyQXh6NGNCSXBXeUpz?=
 =?utf-8?B?Y0MyTmhnOElaR2FyeUJoUWRoQk5wVXk4UGNES292cnBZQ0tTclZ2d3JEQmxt?=
 =?utf-8?B?QkVwcER6b3ZtTVRGRUNjcStrbWowSzhQNmpJSVRsOFdKcFJhUmlQV3lSelJj?=
 =?utf-8?B?UVVVZlJqYkJzdlJEdmQ1Y3QwNlhEMEJ5eHJBRW1KTlBndlMxRkQ1NHlPaHBu?=
 =?utf-8?B?QVVWWkJ0WFpLZmY3V3FpQWxuaFdMUlBobWEwOVhYazkrTlhUaGdaQ2ErcEtw?=
 =?utf-8?B?b2Zubzh2MHhlN2xxazNCTnVGQ2w0UG8rRGdSK3NkNjJiWXJsaFRMVkZYNnFp?=
 =?utf-8?B?VlVXeTdXZGRTTGlXRGtPM0pwTHlUSmZadXljSDE0bjVLWkJqUEkwQVg2MjZv?=
 =?utf-8?B?c3RrN05yTW1KOVJZY3pweTVCaHRKNW1BbzNUWm9uUW0vQ2hid01oR2M4TWpJ?=
 =?utf-8?B?Y25VSkg4UkNvZWVJTzNjbTI0ZUIyOVllYnMxVDN0cFNocGJoNjZzVm5XVUpi?=
 =?utf-8?B?SnV5N05mMnVpVFBoNnV4WXhqQnRNQXNBd1FVVk4vVlZRZnNSUk5jREorUFZw?=
 =?utf-8?B?MnJieVBSaTl2a0JRcm5wK1NKeXF6S2tIR200Qm9CcVBYR1JubVNic3RJczVO?=
 =?utf-8?B?M2pXYm55NmgxRFdoYzNIeGdOblVuaXFNVmxiZ2NXQ0pRUTZBd2RvNDJJY3Fs?=
 =?utf-8?B?QVZ0aDUwbkpTTnJPUGdUSElzQjF0MjFCcGJJQXlDcS9BbVFsVDdlbTByRjFq?=
 =?utf-8?B?WmI4VVVyNnBXby8rRVpFV1d4NWZ1WjlWblE0b1VKdVZOVTZiR2JQNGJVOVRD?=
 =?utf-8?B?Sk4rOVNvOXMvTjF3QUtQdnRtRko0bVRnNU5tUDR5SEhnenZ1bW9DaVNLM1hz?=
 =?utf-8?B?c3ZxUDcxVTRjVXE4M25wOEptSlkrTFVhTXdKNFJwd285WTY4QXNBYmNIRTMz?=
 =?utf-8?B?clo5SHRiTFZqbXZTQXNMUCtyeTgrY2RKVTZ4YVRHMHU3TC9ONEZVS1BiYnFs?=
 =?utf-8?B?dnVKMTBlSXhqYkVBbjZEYjFQRVRGSVhhaDZKTno0TDFEbWp2LzFieTNXUVF6?=
 =?utf-8?B?TFZQTS81YUtOb3piMjNlWE4wbXhsUDBVc3gwdm11Um5xNzU1Zk9RaW00enFj?=
 =?utf-8?B?VUVpTXVzamxSOFFkdW5vOUtheGlTd2FocFVIUkRZRUR5Z2txM0tjaWJmK1E1?=
 =?utf-8?B?UHBzSEJVNGQ5OG9kV0dnYXZvclBlaUF2S0MrWllxYVYvTW0yMXFjajZ5ZmV3?=
 =?utf-8?B?YkhpaTlTODh6SVo4VG5pM0JtbFBpNVV5NHpBM0pFVUp4N3pqaHlwOEhmZ0lV?=
 =?utf-8?B?QXNocEFGUjh0VGlLWGptK2FyMkI0Z0JNT2lMMzdDUnJIMmVFb2l3b1lqL2h2?=
 =?utf-8?B?b2pjSzgzMGxxb2ZnaGlaSkdhWEQ2bWFqUlZFTHZ4MGIxR3hnSU8rVFhWZ2Ev?=
 =?utf-8?B?MkhmOXU0TnBsTG9rZTJ4MHZ3bDZjUURpUGhQNDByTXVFMmVaczYrVzJYM2t3?=
 =?utf-8?B?dVpWSFVVUWV2VjFyczJIYjFrbnpucTJUNHJsL3F6YVJEQm1VTUZiMTNGRzZF?=
 =?utf-8?B?bWcwTjZCTXhxNzlXcjU3WlNzMDBxc01hcDZxZ1pabWZkYnhxLzR5UHEyemdI?=
 =?utf-8?B?VGgzVHhXOWxmWHJTVmpJS0VVWTJQU2oxZG9WS3FabW5Eb1pPaE14amlPSVdu?=
 =?utf-8?B?LzhUaU1xalBhODhpTWtQNnhMdXczajFQbzQ4TjQ4NjFWNFZYTlJLRk9IdElz?=
 =?utf-8?B?NU0yOGR3QTVvbGwyZTdwVTFhWUpKR2NJVGM2N1dqQmNTM0U5eGMvb1VmUnkv?=
 =?utf-8?B?d3U5QXh1Ukd3Sld1QVFkTGZiNzVxMTNrT1QxRzlXbHJVaUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1UvdFhkb3VzczYzK3kyVWtLUjh1VTlTeTlsZkZ0VHFqUTFTWXdwcTQrVFU4?=
 =?utf-8?B?UnozNDRzdUdySVRHc1VidUpSbEhZRFJQS3hEM2w3N25QN0t6QUUvZmhjSWJj?=
 =?utf-8?B?UWxkWnd2Q3dUNGRQWTQwRjZ2YThqb3VuRXlscElsSG1TcjI4TDk3M2tpUVZW?=
 =?utf-8?B?V3RQME13aXZrbFVSZlpxTHpFUE5zU3MyYmpOLytvNHpITGpiU2xLRmtHaDlL?=
 =?utf-8?B?cG85YXRqZ2RvSEZuMlZwTmRiY0ZYNjdlM0gzVVJ0QTZrL0s1OVJ0YU90dXNq?=
 =?utf-8?B?ZWtYWHhGaks0VWRrR0hJSHZSWlpzdDljZmNPOFdxTmdxSTRjNW80UnBSQlgy?=
 =?utf-8?B?UXlJMWZWUyt3TVNHejdpenZna2hMaGNBdDN5b0F2dzhVTk0wNEZxRlpzR2Ew?=
 =?utf-8?B?cy9YYlpLb3JxRFBQdjJUR1A4VldYb010ZGlPbFVVTCtWc0JXRWw2VDgreHR0?=
 =?utf-8?B?YldXeEF6WGkwbm4zWVpsWkk2d1I3OXcyMTQ1ZnJDWlZiVTRCbExlcGFxbmts?=
 =?utf-8?B?MnVGNW9ZMkJOWWtERlJlZFBrZGFTTlJXZFNpSzQvQldaNkJVeUl4RWx0aDBU?=
 =?utf-8?B?Tk80eW1zOVRGdTdPY05DR2FUazhhOG9Yc1QrcmhLU1UyU1ppWXNwd1Q3cnJY?=
 =?utf-8?B?UDIrc3RDaTZTNU9sdTlhRzNBVHNoR1QyN3dEbGUyM1VxdC9Ec3laVERodmJQ?=
 =?utf-8?B?ZzYxWVdZNHM3RTBqOHRuYnpIaEZ0b2NxSFltUU0zbjgvSWJlcHdYWnZLVlJh?=
 =?utf-8?B?ODNQSnpJU2VqVnJQbDg1OHc0citmQytJSEpFZlJwcTIwalE4SFdjNGEvMXFB?=
 =?utf-8?B?M0ZzUmpQVVJnMGczNkppQ29wS00zSnR1c1d5NlJiY2pPNEJ2bFRwWjVyZmZI?=
 =?utf-8?B?Rm1BeFVNSlZjZjRjWm1CaGsveEc1WTA3emFhZFRrbnllS2JydFd4YlNsZUdI?=
 =?utf-8?B?UlJiQWRSMVZVcEdGRlZpcGgvOUVHWU1SOW8wR2pkMUFocVJDZ2FoNHlYK3NQ?=
 =?utf-8?B?N052aEx6UCtyQzRqbEtXaHc5NE5pcEFiNS91aUpjWUhBQUsvYzZiRnh0b1VM?=
 =?utf-8?B?TEhubWxxQ0FKWnVtTzlXTXlxc0ozS1dQYUxkWGdtNVR2R1VRallXcWlpemFW?=
 =?utf-8?B?WGRZaGF5U0VYN1ZtVys4ZWZLRjdUWmVScXpWRS9XalIwTUpwRTJ0K3FpTFZU?=
 =?utf-8?B?SnR3RUhWZ3g1bldlWlF1cnkybUFrMHVMSEpFZ1VsSHhxOGdZTEVjYjZFR1Qr?=
 =?utf-8?B?cEF2UThwdUFZQ3dWZkNJdnIyekk2T3gydm9ydkRrVXRpRnJuMkxlN0NOME9u?=
 =?utf-8?B?VkE3eDZORVgrS28wWkFzVmh5RDEyUzFBdklzZXZ1NGFNNGRPZmZSTmVQQmJt?=
 =?utf-8?B?Q3JuNlVUakFLQmRXa3RLNlNJT3pNYWNyOHQ4WmFVUi9KeTI3V1AwT1pPdEpm?=
 =?utf-8?B?R3JOZGpNaGZJUlNSLytsWGFDVDBveVNGdzdOKzBpNmF2Wk01M1pZZHNLNFl4?=
 =?utf-8?B?OXNNbXdVZHVCcEFvZGRDTjhkNmxLbjE2L05ibTl1ZGhHUDc1OC9xVmRrRExK?=
 =?utf-8?B?WkpQcFZwY0xuMFBIdUlRdVhiZWc4ZGJMRVJmOUN3NEVEMWxmc3JiSG02RWN2?=
 =?utf-8?B?VGphV0ZBSjhISDJXYWhUZ3RpL2QxOU5JRDJYdVI4WVIvQTY5MThRdjBLOUdB?=
 =?utf-8?B?MlRhNHEzTGxralFSWm55cktYY3lGNm9OaEZzZXdqemtKZmdKSTc3eVJ1akpP?=
 =?utf-8?B?MjBPeVhrVnQyWXhqMTFvL0M1Nk1Md1ZReld1b2NZbEpjSDFNaUxEZ1BGblo4?=
 =?utf-8?B?RGYySjhxSkZuSWlmUTBmN3ZML2hBQXZWcytnR3JNN0JZNHhSUG5HYkg5SkQv?=
 =?utf-8?B?b09GOTZwNzNmSE9abURMTjQwMWROeFk3NWhTZWxDZ3dQTWUwbS8yV1NBU3Js?=
 =?utf-8?B?QTVIL2lsenpmUGN2SmV4L0pONSsraUV3bEJIVWtOd2ZIT2hRdHhFWGpYL0pt?=
 =?utf-8?B?Q1BoY2o1NVdzR1RabE51WDB4T1R5NzVSeVBlckJZd3pkUkNYenoyR21YRi9v?=
 =?utf-8?B?dU11aTNkcEFvcmdQcy81YVc1bk1JL2t1R1dXdkN0TUxUc05KOC9lSXpJWU56?=
 =?utf-8?Q?E5QE5XNeyw2Yf00AcSBe1thnS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5d23c6-5ef1-47d2-73da-08dca1d61de5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:20:17.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tB9RHFudSs4i+8s8copdpC6QBlswaMCD9UigbkqBdYTbpX6cVjvICVadvxsyNqzMbOEgfXQ/z7zTsgw96w+0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: haibo.chen@nxp.com
Cc: imx@lists.linux.dev
Cc: han.xu@nxp.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chircu-Mare Bogdan-Petru (1):
      can: flexcan: Add S32V234 support to FlexCAN driver

Frank Li (1):
      dt-bindings: can: fsl,flexcan: add compatible string fsl,s32v234-flexcan

Haibo Chen (2):
      bingdings: can: flexcan: move fsl,imx95-flexcan standalone
      can: flexcan: add wakeup support for imx95

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  5 +-
 drivers/net/can/flexcan/flexcan-core.c             | 54 ++++++++++++++++++++--
 drivers/net/can/flexcan/flexcan.h                  |  2 +
 3 files changed, 53 insertions(+), 8 deletions(-)
---
base-commit: a4cf44c1ad6471737cf687b1f1644cf33641e738
change-id: 20240709-flexcan-c75cfef2acb9

Best regards,
---
Frank Li <Frank.Li@nxp.com>


