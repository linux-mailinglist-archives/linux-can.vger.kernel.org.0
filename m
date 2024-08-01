Return-Path: <linux-can+bounces-1097-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95D9439D6
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 02:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39D71C20CA8
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 00:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A5913A3F2;
	Thu,  1 Aug 2024 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BuPpN6h8"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD7A131182;
	Thu,  1 Aug 2024 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470445; cv=fail; b=V6AV1ZJiNzzk4DFF7Sqhu32htk0ETnIT6LqZUB1zPvr0hmmgq6paUkUEvAW/VJR966qt8bhpFVg5WHwccR3nCGjSAfhPQC9ix7PcDxIPUtt6qE5GBqEdtbd8HJXODLBrg1in3scISXc2JZdJZ7rHHhAeniz1xJVsl5QnUywaxlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470445; c=relaxed/simple;
	bh=+DIGgBkBWyrtYQfrFvCkUgA9e8HOpEMFLYOPNyi1qdI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cft5qrc+asuiBCgN2Hy2vMInr3RRwOOLCiSxhZFfQSKxi/Lzs675CzwExKO4CRJvIalQcKYTnEUpZvZIf5cRtt4MtIFSl+ljQAoXiSTK+Odc2qLEZd3tRXI8Sh+9belIZ57fGMPhS8uRF0h4OFtwYWdsfUFitg0M+DngLw/UBpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BuPpN6h8; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUPf4ft3gVF2fukSy1l1MpppnAMd44ZuYY2lewxRY2DYWCTESz0ZJKDBQqypm17mE0rEBxLqcvojwrEYBO2h+A3QpVqGckQejpzklHm9Ri0YU01D/IcLB4KIE5GOMf1KIdEdtrnxlKoUKHwB5FW0LHwsbtrAZv1XEfw204pcvGODn4f30HHzVkzlAhrkoRMXlYrS5StJfZSQaJK/4953YApFDn0edMY5OmmkjtwzWPDTMjbKm1BoHP1csYGEoPvVAV0MovGUxRIe8Up0FMhffkGJyeFS/Wt8tg4OINK8VOHVnSm0TKnwYTxcb0P99nHfjbOgLvRdeiTwMjdmWpt6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOd6FLZLIcIbPo0Sq0J+NOU0MeVyh5JVCAAuAq9yNW8=;
 b=yAW90NdIMcuI39k1dgovf6CLqz+/OpV3uERFv7wbT/VLHde0rY0ceUibtiF1A9mLbjUQ6lx1MEFVhIr+dh4LEDBW6anN+f+gQzpBGTaAzzagrXpgRQcPsy1JT0XzSJPRjt1hrG38YzOH5qNTHK397C8GlkI/2JPd9c1pbuFrvEgDNp7xKdJQKEq7PQFB2LWBN++HMk/x+1lI0t7pd1IAW8ZsHC3YWkexROWaWOK58e/aKG/VD8J51b9nczS8voJ4hNc5mDMbZ4J9KpWI/HrrX75UwAW03vS8A73YTyk1y09F6YEAtJygVoHGx8fzSEBwLqv/k62LiInEiloTm9X5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOd6FLZLIcIbPo0Sq0J+NOU0MeVyh5JVCAAuAq9yNW8=;
 b=BuPpN6h8umnJqOqfi2q8t7IO8EbiPUTLuroDHMIPsN/MX4tLWq2lMn8VLHa91fvOR7+kBzY1H0IAkmpFRE7ZvUV6UVQuXAzMWtnU6x/gwt7V0g1M2qygznAbOyQgzPDXWErmhVspcBGWq4zbGu/L2b0fWsj/nBVqfIxIKZFNigNxmrKWch4FZh75jhsFuBafrB5CIPwHDoSBWbUkwOl0MNBiMJJi38+yHf0q9XhUnmK2E6Wnnwu69zF2a+ChRaIjmacDUu7zEUShkgFArv3jVgECOcuMl3TEv1u6KdmI3E9i5UwiaSKsxIYysjzoc2Ej2qDdDW5ypzBwAJluLZULDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10406.eurprd04.prod.outlook.com (2603:10a6:150:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 00:00:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 00:00:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 31 Jul 2024 20:00:25 -0400
Subject: [PATCH v4 1/2] dt-bindings: can: fsl,flexcan: move
 fsl,imx95-flexcan standalone
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-flexcan-v4-1-82ece66e5a76@nxp.com>
References: <20240731-flexcan-v4-0-82ece66e5a76@nxp.com>
In-Reply-To: <20240731-flexcan-v4-0-82ece66e5a76@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722470433; l=1301;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=27/RZ5zCVbTg9TNZoQv/itKKz/Wfggk4JwdgIMWCZlY=;
 b=AFJNs7QbZtuXOjgRtyV2TpwxBYqiQGHkci4mUV6Z+Xm4fjzchhyOfmaUONIy1UrPmysFyYI1L
 CHr3RJQuYE+BLwoXmy3rlODSZCbx3qk+Jk2iASNQxhSQcm0SmbI1L2C
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10406:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c10c5bd-4235-4606-e45f-08dcb1bcfbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE9EZmZDQklwbU1pdS9VK1ZPVHpsdEVGRVFQWWJtUUVSUDMzajh1dXVuU3lF?=
 =?utf-8?B?MWhEVVJ0R0NmbGQ0YXZDckVYMFRIYnR6UEt4ZGV6Mkh5WmpVK0FNWHJLM1B4?=
 =?utf-8?B?NWdYb3NLcjNQYUlXV0VkeStCR2dVTnNhUDBWeUwzMU5RdzhXaWpUdFMzSTBi?=
 =?utf-8?B?YUI1b0lya0JxdTcrUmZzK1RFeVdWQVRsdkRqMkFVWUQxQUgwZkE0bUNvdUk3?=
 =?utf-8?B?amZLOFoxWSt6eEJHN1JKV0NSYzlibkxaYXFycS9Pc2ZEVGNYUjEvNUIzZ2F1?=
 =?utf-8?B?ZVkvUGE2ZkZBNk5ydldFSThrNmI0Q3Z1T2RZekxqNkx4c0tPQTdPckRZdlNF?=
 =?utf-8?B?WWY4V3d2Z3hHcnYwN0JrZGY1ZnpzWEYwKzdJL0FFRkZNRWIwM3JVM2QwcUdD?=
 =?utf-8?B?cWlMZjJLRDVKWnBhVS9LTXFoQ0NlMXdFdXFIUTlNQ1dDNU15UExYQ1RaSHpG?=
 =?utf-8?B?MmtuTmJmZlR5Q2NZYm9wZGxZRmlEWTR5b05yQUVCTDc0Rm44eElWTHFHUkxi?=
 =?utf-8?B?eFpMeFFmU2REQUJNQXVqRGUzQTNxRk1sSUJFVHliTjJDYjhZZ3dYVVRBR3dM?=
 =?utf-8?B?VkhhcHhqUEFIZSs5dklZckpKb0dZY1pDR043T2N0djREd21PczVxdkc3T0tB?=
 =?utf-8?B?eWQvM0ZxVDh3MEI1bjFzeXJDU1QxRDF3QzhoR2sybXJGaDVVSkFOT3BRc1Vv?=
 =?utf-8?B?cXBvc1ZDUm50RUhHOS9aV1BPbmFTT0ExZ0FPanVoeFh6bnVkZGNPdEh2TC9s?=
 =?utf-8?B?REdlQTBORUVqRTNiK05uc0gySHpMbm95ZXladmEvOXJDYkpZbUtSak9LTGp2?=
 =?utf-8?B?Rjd4M1E0Mk03b3YxMzFKVjYrbFBka3ZQVDF1WVRqcmFwamx4a0Z5NDA4MzBi?=
 =?utf-8?B?V2dnNVV4aitaNmVOaWFjank5ZWJRczRaQ01la084eVd2Z1psdUFNc0NzaHBV?=
 =?utf-8?B?T016OXlkWEx3NU1uZ3NmSDNMMHFLMzVQN0d1RGx1RXlla0Voc3pDTFdGQXFZ?=
 =?utf-8?B?aUFGU0RuRklvVmJCdTRpNG05MnNMdUNuejg1NXo4VWYyUlJYYTlqbFFmZEhl?=
 =?utf-8?B?L280SUYvYWwwcDZkNUJLWHZQWmJPNUczSFQ3SjJjRDI0Tjg1QjVYYmEvQ2xJ?=
 =?utf-8?B?clVKM3ZlN2Z2c2RkeWVUSTMxenBFd1NyZys4LzMzTUVIR0dPUUtBdVZYckhk?=
 =?utf-8?B?bDlYUkNMVC9lU0hmd05SS1R1REN5Vjc1S0wwN29EbU9HMlQzU3lRQ2hvQ1Vj?=
 =?utf-8?B?d085SzduMEhHeUJ1ZExFazNjOVRhS3N6SjlxZ0tSbDdoYVZpcTJiRVpVdlZn?=
 =?utf-8?B?K09PUjhoaWsxaS90bnB2UmJ5Z1YyeGdkSU4vMWxWUzVKQnJyazlrNUg2M2NB?=
 =?utf-8?B?OEpFLzF3a1R4YnkyRHN0c2FZdW9zdWhVY2lYZEpRblZyQk5YWVhVWmQ2ZHV6?=
 =?utf-8?B?bkRoU0xkajEzN3ArOFRSb3hMNGw3cktFaGphS3lKNnl5SU1yVEl6NGVNYmVm?=
 =?utf-8?B?clY1aG4wSlVteFNXUVJNVmFVeVBZZnhvOU1ITC9jbmtDVXkvbEp3OTRnYzI2?=
 =?utf-8?B?T1ZxT1k2VWwzZUZ3N0FhWDFERGtqOVdzNXpEY3RMMmVPVVZKZjdXSzZPZVFs?=
 =?utf-8?B?aXc0d0Zzbkk2cnltUzl5TElsZGYvb0xmaWplZFFheUt4VkVBem8zYTB4a3Jn?=
 =?utf-8?B?aXlQa0V2RGhESk53RWdPQ3VWSjZmZjdjS3ZSZk1LMGJYZzVyZkVDNHMxTnEr?=
 =?utf-8?B?d3pObGsvQW9hZzRiQlhCaE16RktEQkdGTHd2d2VyQW55WURJVURobitlQit3?=
 =?utf-8?B?UDVzVGJIeUsxaVJVeWh1U0lSWW1MbVNpSUFMYUxxVU1vdXlkQWpILytWZ0Iv?=
 =?utf-8?B?L1BCd21SVGUyT1RUQ2JsTVZOTVhaSk1FMHZQRWFxc1VHK1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFDWTF1K2pJR2hleG1Hc3FTQ28zUncxTXNoMkJDd0xTd3lnbWc3TTVsKzEv?=
 =?utf-8?B?Vm9jdGhkempjamJHMEFDTXU0aXFVdE9ySzVBYStEb2tYTXk1K1M4enYvcVVr?=
 =?utf-8?B?QjZZV3ZTYnExMEJSRmRaRHlJZE1YbEw4aDhXbTcxNXBEaSsxSFMwdjVFdjE3?=
 =?utf-8?B?RXVaaWNYZFo2TXhrMHkyeGhMWTc4YVZFc1hnWGtvY2VZWmJHQSt4UyszK1hv?=
 =?utf-8?B?U3Uzd3JXeThRWjduR2VBQ3Z6UkFlZkgyZkwrU3hHNTZoNitkckMzN3VXQ29C?=
 =?utf-8?B?MklkT3hVUjF5VmI1VUU0MnM4Qk9KbE5ibjhFcGdOWFJRdmt3b2o2MitmMTF1?=
 =?utf-8?B?dk9YZFpjSHlvNmZhVi84dVdEQ2Q1MU00M3pIVkR4ckZaR3hIOW51M0NCVExs?=
 =?utf-8?B?bWxEcWI3R2RjMXNVVzgrMkJ1K29lOTR1ZHlWMzBHMUJLWmNGRk9LbmJsY3kv?=
 =?utf-8?B?Q3M4S25VQlZYSEs0ZllPbDVJcnVTQ1VhOWtNVnBjWXpId0hTbzRoM1pLOGQx?=
 =?utf-8?B?S3ZqOVJBOGliMWRCV2pzNElEOE44cjZmbll3dFVsYkdhOGt4THZGL1lRSVRG?=
 =?utf-8?B?YjJwVmRuSWhRc2JGQWdQZEszR3NlWENGc2RYYWg5dEhPNmphdmRzejE4L1VI?=
 =?utf-8?B?aDFYVnlJTi85VXdXbDd0ZERkWVlKMGhmWmhXUzJQbkc0RnJkbXdXVTNTZE9j?=
 =?utf-8?B?S2FkdnhaT3NLZHdSMWNhWThsWkhCUTdWdW9WWnIxWU5kbE5wbEgxQjMzL0Ft?=
 =?utf-8?B?VXJIajhZZkdkWkZYUFBCbXcwbUpCZXc5Ly95YzlpeGxienQrQW9IL29XQnlJ?=
 =?utf-8?B?V0w5TFhvNlBMWHJCa2tId2FEZnlDalc2S2I3WTF0U2dISzh6ZjBoK3RoMmVQ?=
 =?utf-8?B?eGRuNnBqUExEamMxTTkwc0QyYzdjTCt4RzE5bUZkUThMSkh6U1BGWHBGbWZT?=
 =?utf-8?B?UmhXSElvSzhzbzdxTGxwK3RsSjkwV1Y2MXFWNnJhWHdpS3FYSVdBckt0UUZw?=
 =?utf-8?B?NVdnbG40ZWE1WlZ1OTE0ZnY3RTk0SHhBNllDbHVXQ3A0VVdpWFF6TkRsWmYy?=
 =?utf-8?B?WW9RdzlSWkRqa0dTQmlOdFpDYTMzcGxaajE0MW5kQVJRV1ZJZW5yVlJ1RUYw?=
 =?utf-8?B?Z2FFOE50Nzc1Tll6STdnTk1vQmJsK2ZuRldWNDQ2UXMvS1ZqYXp4azB0SHNK?=
 =?utf-8?B?Zi9lNnN2OUVoQnNUWDJ5SUdRTGdQL0tvTk1oT0NwOEFDZUtjZml4MXZLTTlW?=
 =?utf-8?B?eUhlN1NLYnVQdk9pMGtrcGhJWU0xeEdqWHpFZko2MDZCV3V4ZGdwNEQvSjFl?=
 =?utf-8?B?WWNRaVF4eTJJUXF5RElaTEh4ODFmSnhVcDl4dGl5Tm1TdmlDNEEzYVhmMmJw?=
 =?utf-8?B?eXhvNGlIeGVOZXh5ZWhaOFE4enF0eCtVeTJ0bjNBRG5tR09ySUVNYjJqMFho?=
 =?utf-8?B?VEdzZ2hORWUvOWk0OTJLZFBaSmRILzFseUFKekl2SXFoczIxc3BkZnRFV2Vx?=
 =?utf-8?B?bEJST255eXVMWDdjTGxGMEdhME9CMExpVUtrSnNNTzc4Y2NFYUVNNUNYSXNK?=
 =?utf-8?B?NDE4Tm1mT09GWVZIWmZ3UGN1bWZCbEk5SkJkVDlORlVhVGlKSkhESEgxR1c0?=
 =?utf-8?B?UkNDa1lFTU9RUldnbGJGV3lUa1VHT2F4VnRVdWpyNDVlT3Y5Tk45WUQrbWdt?=
 =?utf-8?B?dlF6TzFQVzVnRm1GSEFWNFJEeERFczdEWmE1WDJERU8yUWduMEZLdkR3VnJo?=
 =?utf-8?B?a1Ywc0U2MjNHT3E2NE9SMk1jeHRaRW5nOFp0V3hrQTNOQ0k1TldsYnJjZXFD?=
 =?utf-8?B?MXhiWnNTTEdGOFlTUDIvU2p1YUswbUtVOHVBV2ZubFovSHdxQ1pUZU9qV2lz?=
 =?utf-8?B?cHR6Nmx0Znp4RTM4WGJDRDNqQ04yMVFvZkpxR0tJeDRvMEdtT3BlRy9yaTR3?=
 =?utf-8?B?Wm1nbWkzeEQwK2VCZzVIcnRkUWw0a0NOZUZtbHp3WEtIb3ZwQWQ0aU1hZDl0?=
 =?utf-8?B?UE9vRWNQOUJPUmdoSzYxZFlHQ3RKa1hTRUViUkNlVXVNeFF5RFlBOWNsSHlt?=
 =?utf-8?B?c1NqRVRUdnVsV2Rrc2NqakNFdkdoejNNS2dtejhtODJwaCtXb1RZYUFPSXNy?=
 =?utf-8?Q?X1W9qxx/USlAlAb4Jr+Rkcyin?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c10c5bd-4235-4606-e45f-08dcb1bcfbce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 00:00:41.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32lBsQizggUUTTaWjhqMywWhW3E98YgBw6H/rFFAvSNXl6TtUiGQXM4sU10bR/zCyRSzJgsw/i/S5mQUdIzg4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10406

From: Haibo Chen <haibo.chen@nxp.com>

The flexcan in iMX95 is not compatible with imx93 because wakeup method is
difference. Make fsl,imx95-flexcan not fallback to fsl,imx93-flexcan.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


