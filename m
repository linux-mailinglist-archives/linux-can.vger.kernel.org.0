Return-Path: <linux-can+bounces-966-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B743392EEC5
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5461C214AA
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4D16F0E1;
	Thu, 11 Jul 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DPlINfqP"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785B16EC14;
	Thu, 11 Jul 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722033; cv=fail; b=THkKWRBAdco93ziE2ECxzNtMjL2C16RLQq1WQ0YP43X3zsKvQBL+gWRBnAyNAOMNO0NxhywodUJ4UHRPG1vd/Eht9uCXT4Nrnd18YvaBMPzR/dRpuvbSPzan4cLvlzFzs2p5df1iCBt6kop9j8Eo4eD58CdcQzqbvrGofaKEN8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722033; c=relaxed/simple;
	bh=psiAQr5zH/2twLHF/sa8uAK72vHgmvNSObmddI/7DJs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Bu2c4O3xsrVGni26CiMscHjwfMRJc5x86/xY9NWukJ2bEA4dKXtOxlZndPxd6LKpsogARqGatraBBDR4GZtF7Wcy1O8Y5W07amA+TnUT6eo2qkOuPgkVLSxu/IB8lXgG0m3sIabikZeSoCRSEaKJhv2K41xA0kUQ5O0Mk44nf7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DPlINfqP; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAnNs1QulCkWCTKEe6C8c8VPGQci6u9ujtIwoE2v48l57Bb9vMW8TxruKrdGFYapL8QZt8IJMDcO/xyTlzvnZDttXq3hKRBoOr8MH3XzoOtCtVMfDYR2wbZXYoOhGh4/ZTJnqu2cMSYu9eKiqleXRTBRXiyUylojdZzBzgaectoFe6WrXEL5F96LH98lN6jeV4X6Q1Tn8H0Wga1Ez5JO/FJGB8YNQY5zkQQ2IXgEfDqv+WMmdB/VLMtfpuP1qiWSDPYIo2Mb6arp5KreJUqVxPMdzPQhTDhBIouGGSElC+Xk7jWBsQ8FbpY5h/PlDJqgWrwtRTlfG5rGLuR5wOqt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RAOfFpBsOuLtX1rwe3lAbrqODqZC7/dCJhCvjjl5j0=;
 b=iIZOGfaeclfCn9Xa+3QeVx755O6SijZATsnnfqLiY3Ovu4nWGUOCQMCvVff4PFb8t7lHAMzLpyouuujApS4poj0z+9MyO7uveXP+XbpoqvNgBLu1ixsh0U4Qv0gyLS4Xie4WMsbjx2unqmD+9jMoSgaaZh8+J+L+Z/Ia80CcD10DnrVIzfdTdfQRewQd3c8D8ib7TV+DdfFe0ywez3g6OaPeGRkgk0X8buvAbMjbNmNmVEP8D5+tKMfwESOErcnxO9dZo7nx9KmkWGGnmKx7kzbueOlwn0eiOhw3Lz+gFPD3wMj12EyLxViQY2kNwDtvREMqJ/1rBBU5CRXRVmUwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RAOfFpBsOuLtX1rwe3lAbrqODqZC7/dCJhCvjjl5j0=;
 b=DPlINfqPiFzKOHmI7UmEJnQDUKIprqAuwEkosO7o8b+clYVKrdS+b/XK48jau8YiB1i9QFsfYTPMziFEhr9G3QWrY8nm751VilwlMISPj77XfJ1wETMtI6LBPQSPlhsKFYiMAdK8l8M+GEIsRvgXZM9j+eSNiyg3fi2Wa7nRXz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 18:20:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:20:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Jul 2024 14:20:02 -0400
Subject: [PATCH 3/4] bingdings: can: flexcan: move fsl,imx95-flexcan
 standalone
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-flexcan-v1-3-d5210ec0a34b@nxp.com>
References: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
In-Reply-To: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720722012; l=1251;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=h3RgjaAVphdcUYL47pzf0t2pJnMnLqmHnbv21aG/vEk=;
 b=uM892wVDAGA+B0Qf3hEmlwGDVwEEdyGHs7ZwT0LDU+G+UU6J1+xiCvMRAqMnALvvQoVvrTh6J
 d7E7C5lu3f5DRgz8+DlXkF3gwZKlfD7ZOGbfzY+4EdbfJwhFNSTYiY9
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
X-MS-Office365-Filtering-Correlation-Id: 8cf90e6d-2f77-4c16-dafa-08dca1d625c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUt0Y1RXUmFLVCs5YUwwM05qSlFHOE40MVRiSllYcHk3LzJXd05MREtocDUv?=
 =?utf-8?B?eW5PdzkxQWxVU21QbHZ1c0labnRFSzJYdHRhcXpYTDB5OVBJd05RTHpBMnk3?=
 =?utf-8?B?WjFBaGRrMGNabjVtdjd5bHY1SXZFM0ZzOEZ2RGcyQVQxODIveUdYYlptNGtP?=
 =?utf-8?B?RU1iM0JwZWsxaVpHRUpPd2g3ZVNOaTFrUmVubFErejBrRUZqZCtJbXptOVlB?=
 =?utf-8?B?ajBkcG1Ga1lMTnNrRGZDdkVFWEg2QjlYZVJEOXJxdUt5OFVTbGJCMWFsMkFH?=
 =?utf-8?B?K1FPM2R3cVFkRGFZSUxKQ0IrRys5OVlvS1hSN0dnbEhCVEh3eEZ0eGJRM0hF?=
 =?utf-8?B?TGt3K0pzczBJckpUalIycGEvRmdyVUsxK1VBbEFlbThVOUJxQmRDQTU1TktZ?=
 =?utf-8?B?cWtHeTdGcEorMmRVOXRVVVArb3FXZTUvSzlLSlMvejdKSXVzMmgzWjRQN1VK?=
 =?utf-8?B?WHNJNnFxaGVob21iWDRIZnBLN3oxRGN6SnlNQ0VnbWxCNmk5QWpBTDFIeDJy?=
 =?utf-8?B?V29wZFp2d3lUSkc3RGtkUHAvRHN3K3RGWHQxMU1BODdoNGJaN2pqSW5EN1Fp?=
 =?utf-8?B?ZE45U29lMjRxTHVETVhwTkVJU0x3Y1E3S0YxT0xaYThUZGdWaDJKK1U0eW9y?=
 =?utf-8?B?WE56VGExNGplOEplQjJESjM5RTBOUlZNZHcrVUM1MjhUbUhiTFlnOWs0MGVI?=
 =?utf-8?B?bFEzRHRrcmNDeGdWVUlTY2VZUDloUDFOS21nZnZDRklXallSV3JtZS9RNkpU?=
 =?utf-8?B?MmhJWXIvNUFUS1pRYkc2K2VxNkc5Q2oxYmQwdWNxM2dIYjdxbEFjQ0hJOW44?=
 =?utf-8?B?QTNiS1ZERlh2NHIwWWovSTd4MXNwK0xOQitpclROTW1RazdETG9iOWwyazlX?=
 =?utf-8?B?UHZVTWx1QjZSbjBvbENncnF3cTNrRTVsYkExVWg1d3RxU1BuTG9yR0lIcjlj?=
 =?utf-8?B?Njl2azFXbkFDTUZIMDBGZnNSaDUzRFRhVkxNeW9YTlloRTFZWjgyaDlEZ3dP?=
 =?utf-8?B?M2F3U1Z2dkdLRTNuS1NJcXRFUUhYRFpyY0JZWFhkTFl3UXozaWtQcnBRUGxk?=
 =?utf-8?B?TGxML3dGWHhaUEY4MWdRMnlJSFZyaDZISlM3WXh5MmkrNmM5Y2NxOElUSy9J?=
 =?utf-8?B?V1B2ZmFJZ1M5Z00xcmFhMXEzNDFTT0RIdHYwQjFUaVUxSEJRWXdqelp4Mk5x?=
 =?utf-8?B?MUpuLzJ4bkkyY3lRaWFxL3FjZFdLLzV0M0U2YUlCbWkrSlpxYU9CWWpMYTJJ?=
 =?utf-8?B?UEdTdklGRVYvSVYrQ1NQZWk4TkpCY1FGZWM0emRjcys3SWNwaG1YOVNVVWtD?=
 =?utf-8?B?VFdWT3R1ekEyWlpTdEpvY2RwckY5WE1Ia3UxMDNTWlh0MER2RkV6QW0wcWhQ?=
 =?utf-8?B?NjBnR0llMDIvTm1tUGFqMU1GSDlqd0ZlZ2lrQ3FFRENOaHp3amN0RmNYUGpE?=
 =?utf-8?B?anZhT3NuT015dWtVaFB0ZUlad09CUE5uYUN6SGxCZmk1WmRXNEZQZGFKT1Nn?=
 =?utf-8?B?TnlYOWoyTWpqbkR5QU8yb0diWWM5UDRnMngyNndqT2lCSDNPRWtFZEdZM1Rj?=
 =?utf-8?B?dFRYOUFvZzI1YzVIVEtWanZLc0ZJU2x5b1huc29RcmhId2FDQmU4Z0daSm9j?=
 =?utf-8?B?UmpVQzl6bU40ZEN5ZHhLZjB4c0VyaVhBTEFtbUQyUkh4L2Jnc1N0K3RITmZl?=
 =?utf-8?B?UGVsMUc0ODFwV1hHMEI0ZkhyWEpvckdLYXZlQ3FWRlBTK0huZzdGWHcrc1Q3?=
 =?utf-8?B?cWhvUWE1aUc2THZ1amlVN0NITS9EUExSelVITWp3dlcwNWxEZWsyS0pFaVpy?=
 =?utf-8?B?L1BWRFNsL0VjNFZ6Z0R6bDQ2emY3VkFad2cweGJYV2hGY2VMd25nN2xBb3py?=
 =?utf-8?B?Q1A4RFl5M2xjZVFOeVhLT1l1dnRtMkdBSXpuQkoxUFo1b0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlVKT3ZEbmJCMGhrdFl5ZmljbE1kN3pVRnhxWVZJZ1FwTUdmRE9vQWVmU1hN?=
 =?utf-8?B?cDVwNXFtWTJmdzRzMHZZcDRKYmw2d3lmRGhUZjBqYmVHRjA4QnhEbGpOaGcr?=
 =?utf-8?B?VjFSM09xUGczcTI3Qkx3cjZ2cHJTc3RQYU5hWEpKZENGVStjYndoY1RBUllV?=
 =?utf-8?B?Q0JpRklBVGNjdXNWejIyK1BEVTFKTHBjZXNSUDIrUWdZdDFwN2d5NE1rNzRH?=
 =?utf-8?B?YUU2dHJaQlFHamtlakxkVnF1cERDU0VKakdNRlRaK2d6eU5aUlJFbWo1bGF5?=
 =?utf-8?B?Q1JlZkZkOWhUMFVlc3gyLzI2MXo0R2E2cHhrZkdKTUpHTmhkUmdiVXNHQ0do?=
 =?utf-8?B?QVIrcmlnbDB4TE5XMUxNenFvSzVzR3A1bTROeHpJcEtHanFyK25udmFOWEdt?=
 =?utf-8?B?clBpU20xa3VQVzByb3dhbEYyNWtXOHNaeTVFcGhVanlYVkpxWGFqZnRhRWhG?=
 =?utf-8?B?aXhtWGs2RVEvZ2xjRkc4bWIrak9BZHVmbWx6T2VOV3pZQitWbXJ6am54YWds?=
 =?utf-8?B?cUtwMlBwZWNUNVYwUXVYbzNHRjczR3VIS0NiQmRmeUtkQTBKMWVFU2M4M3FZ?=
 =?utf-8?B?K0lxZHIyODRnSGZpUUlkdlUvYUp2ekE4ek1sa1lIWUZzdWMvQlZScnNncWd1?=
 =?utf-8?B?RkJBT0tZWCtUbXNFYkUzSW1sZStDejN4dnNRY3lMY2RkZ2hGbk9tQlgxQ0l4?=
 =?utf-8?B?c2JhYXpvTThBdFQzWDJZd2RqMUhxYWNzWWx5RUFwQStlRVZyTjJmalpvUk1G?=
 =?utf-8?B?UnJHS29tMUNUZFpnbGlPZFQ1TXMvNE5sQ1ppdVFERHd5UGF4Rm5ZUWhCQjgr?=
 =?utf-8?B?OEhoaVAyRnpyVGFLSGlYT1F4dzg1N1paa3A3UHhDTkdqZ2Zpb1U1WXJoek1Q?=
 =?utf-8?B?RUtza1RwM21QZEZHUk83ZUVLc2NnZklCb1RSOWROWDFyUXRLNEpvL28za1lx?=
 =?utf-8?B?Z0h1dThEOXJ2QWtmVWU0K3p1S09lODdZcmR6MHRkS3pUMmRnZkJDUzFjdm5h?=
 =?utf-8?B?ajBXWEVxZDhZYjFIblVuV0g5VGI0bHNpV1BwWU9SNHcrY0dnZVd0R2RCYmtN?=
 =?utf-8?B?MmRTZDhTVmdPelA3WXRya0d1MTJTUjhFWmZSMTFKUWJqYWlJRkNCbG5pdzAv?=
 =?utf-8?B?RDhtb0ZsemtNaWxkQTludXJTeWZKbkNPS2hJL0pWNmV4N3Q2eGptcHkrSFJm?=
 =?utf-8?B?NWVNdUU0enVXeGFMT0NpM3VxcUw3QUwrcGoxeUtOcFE0UmN5SUJad3ZKT0tj?=
 =?utf-8?B?MmMwc0Q1d1ptTWlNQlBKODJwalB0WUxtMXdSaHBlNHhWMVUzQml4emF6S1l6?=
 =?utf-8?B?MSsva0lxWVg1cEFhNjNoMnhPUG16dWRrb1JSaTZabXgwQnJ0bzJKR2VON3N6?=
 =?utf-8?B?KzNlbDVhSnY4eldaeVZERitOQzZQN01XUm9xamljRTkzWjk3enh3d2hBWlJp?=
 =?utf-8?B?dDIxM0JXZWNERUpRSEtUMDU2NHovb3Vla1hEditSZ0tFV1F4SDRzbmRGaHFV?=
 =?utf-8?B?cy91RXZJNVJMQWhBdHFHNFdBcFRSdzFlYWU3VSsxY1BQR25UVHlaZGZTRXV2?=
 =?utf-8?B?b0ZpZFlzRHJ2ZVRqT056aW90MkpqYi83RHFUMHUwUS9FUVNyaE9VZ2JQeWpQ?=
 =?utf-8?B?OG1MQytPU1RqWE9zZDg0TDduNUVwTGhnS1BNdXZhL285UmFMK3Fhc2hrZ0dQ?=
 =?utf-8?B?dmJLTzArbWxhVTZ4T3FHZmpsRnF6cmFXbjl4QU5iZC9KYTFYTVdkNXdBNVhL?=
 =?utf-8?B?eTRCTnNZOFgrRnZROTFYVHlpN3lOTERZNGhxem1DUFJFeFJDbTloU2RXUFRy?=
 =?utf-8?B?bDlad1duR0pJS1BLU3IwYVlkRjdEYlZLRGRuUDE1aThXaGl2cWRYdDErUnJO?=
 =?utf-8?B?bTF5K0xDVGRFQXFqRDNsVWhLb0VZUi9TTkx4ODc0Ly9EYjNBbE9BemNHa3VE?=
 =?utf-8?B?Q0hBSlBZeXh0SVhYcDh6UDEvTTZuNVdpYTN3TTl3dGdSR3pWQmxndUhJbERq?=
 =?utf-8?B?eVFZbkE0dTZnVEZORUJCZE5acS9pVEJlWTk3VUptbGlxSFpYaG5LbVp5OFpq?=
 =?utf-8?B?TXp1MDNIUG8wOUVVWEZQd21jbkhzUjdibnorV3NzNy8vYXJ5Nyt3M1dFbUhO?=
 =?utf-8?Q?L1rbV5WaLOrrwnDmp0DtqU917?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf90e6d-2f77-4c16-dafa-08dca1d625c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:20:30.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZIaSJ2YzKK31YHXO8H/KtN6XqcWupvBeZDqxBtPkiXFaWgUJX4YFpzNvw2qiFvnHhcUwSngCyuGjZkWXFB5SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514

From: Haibo Chen <haibo.chen@nxp.com>

The flexcan in iMX95 is not compatible with imx93 because wakeup method is
difference. Make fsl,imx95-flexcan not fallback to fsl,imx93-flexcan.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index b6c92684c5e29..c08bd78e3367e 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - fsl,imx95-flexcan
           - fsl,imx93-flexcan
           - fsl,imx8qm-flexcan
           - fsl,imx8mp-flexcan
@@ -39,9 +40,6 @@ properties:
               - fsl,imx6ul-flexcan
               - fsl,imx6sx-flexcan
           - const: fsl,imx6q-flexcan
-      - items:
-          - const: fsl,imx95-flexcan
-          - const: fsl,imx93-flexcan
       - items:
           - enum:
               - fsl,ls1028ar1-flexcan

-- 
2.34.1


