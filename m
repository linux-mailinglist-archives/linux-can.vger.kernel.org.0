Return-Path: <linux-can+bounces-2610-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05450A0B65F
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 13:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB3E1885D64
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C002C22AE75;
	Mon, 13 Jan 2025 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n+JaAueo"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06322A4F1;
	Mon, 13 Jan 2025 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770042; cv=fail; b=ozmnthifrLQmSahlf6e1dKtfoMJAGUNq+hOHxuRo77X5VJ4I0/jUokubfPFDrVzDgeMLzuqYdjUGqJre7Adki6u7cT92R6bpewSBaUhSqXx5ghTx/Z4ZsPUB5JsKTIdboaTW/NKGuYI/gJVXUTTss+Em7lTB9uUJz1D0EEwNdKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770042; c=relaxed/simple;
	bh=D/27Msja/lJBWRfcJFy3VjNENyNFL2o0U4+oVCpi7ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QoZnDNlKFQCmHCCGzSkOA2a7zH2ZwNwnQKmJL4ORooJre6JOwCfPJbNGisWdcA2Hlcs+kEIF6tT6UkCku2U90UTt2mN1emBU/ik6F+2x6Yj3jHBegThPYRe5r5WflZTm1Peyu/8StYhZ8HxGda85iR7LGjtZjEfEdIePkAP5SOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=n+JaAueo; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/xzuroo4z8axkkK7rYxkPZm34kvQmv3SEvjDVh3XuQI8r7MUEQ1yw3hRauNvJna8OzzseIdwMDPnc+Tj7C6Ihad2XR1NsnpOofKVdEZ1XN9oDWPVrZBm2b6z64JNqujecJyqerQ0sereu4SvKGEz/ROY5ZfKPqUKCjj3tQUnPXMsVFErSQI8zGgc0kSrVMgh6Te1NH3tsqaRGW8jzXnzTKmSJdZryKc75db1OSH/9B5nD/gOaKSwI43yR93M275QxRhZaIWZBIteYy0jU3VzRtvGoKzXiSL98SYd/LwgqFESgSqk0iHollkltxkhkNz5kJaZRhGi0ND3h4wEMIvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpZ3L6RcAnRf0eDx7wa22XwJ34ledo9Aicworoq88jQ=;
 b=O+IqajhN5rAjoqIPXNu42EQ6Cv8F/WaXJAQlvXJqTDGXT7kSZAylUjyq7gUoKbHseOyxnLpyemmTfsUISngnoU12gJJrAbGiBNLsepFz5z8nez/WwL0O5HD4sVZjTPcTQRwDLjMY+0z8OjNXCZNDcNdfw+wQy/VtH6h/uqcqNOI4F4SPW+mRUclcAWHZT2PVyqUjugnE7gYcwWKu5Gj6mgTGCu7XBXFYxDzGSTmjF7miik5SkP+YL1N9w7uFAWOMGGynFvDhp+NtOFkhbq0SROPKzRM2kcJiLJXicKn2RzrMzTWw0lbvV2IFOvokSIcS33fHYBZPSEk1PpNuTROuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpZ3L6RcAnRf0eDx7wa22XwJ34ledo9Aicworoq88jQ=;
 b=n+JaAueojXijmamIAsgUUIbR7QMrcq+NQCB/f5ITRt4rSg5Rqoe9tzbXKaxOCIV//DmIvf+r/o2Ie/o/P9gjF4GNlpVyMRFygMZ4vLnAGTD8KMAWJelyBSb9ik6iXHqNTuDRggCd6Z2ewcCAz8lFAMlXeGo9zSJatPSjwoYkmE+QBo2yf65BibR5mUaaL1jYqdgXdvR57mTKcRcF6Dt0qlZ7wR9GptPZjJb62mQUcXkQwm7PfpB2Tr21orUowhQgfam5E7zdDh3PyV1yM5oGNa2TGnnOu04fniTCQ8tyzXqCnZ3DT5RWEC9F0SAjHhZH7A5w0W6ZkysoCnJ4vOSBKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:07:15 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:07:15 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v4 2/3 RESEND] can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
Date: Mon, 13 Jan 2025 14:07:03 +0200
Message-ID: <20250113120704.522307-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
References: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 29995fdc-956c-40a4-f6ca-08dd33cad1db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVF0dldDS3BDd2trMk1RZHVxRVlVRVNxUUdQcmNvODc2WGN2Smlqak5keTV6?=
 =?utf-8?B?Ykg3N2hIVlhwdGJKMDJQUGdSdXpaTDNMM3d1RmtZdnRtMnVhcW1EdTBIL0Vv?=
 =?utf-8?B?RFNEZWIxWWdUdm1IUHozZy9WMyt5cXZhTWZpWWZ3eHhQWlpOTGE5aDAwMGZi?=
 =?utf-8?B?K015Y3lLcnE3Uy93S2VSOCt1RzBSeGhRL1REbmFTNGo4bk94d0NNKzdYUXgz?=
 =?utf-8?B?VTVJZFUxVVhQeVhxTHNEN0VwQTNRbXdkTEJ0dGJEOHdqZTc3d2ltM0xjUEFN?=
 =?utf-8?B?eitLTEttYnZoMWZjd2taL3hKYkRSSkpwQzI4M0djTWNURWEzT1JTd3NVU2VG?=
 =?utf-8?B?c2tuYTQzZ0p4VVZCTmthc0VrUHJMdWYySDA2QkNoVHNnLzVzWmhMak1Semla?=
 =?utf-8?B?ZmxrMDBTZVhsMWdrRHhIRiszMnc4ZTNGaUluSHEwbUlYazJGNytMZ1FYdVhS?=
 =?utf-8?B?V3JYL3dXcDNETDAwZ0lXaGIwbGYzOFptOGQ2U0NFWmZhWHIvaUJpaTBkdHl4?=
 =?utf-8?B?Tys5eWZ4Wnhkc29vR0prUlRzOHpDWnNDZGE2K29pSnpxYU1vOUt2QUMrNEx3?=
 =?utf-8?B?Vy8xUExzNGU4RVQvZUhiWUUrME9wNkNmSG5kbm5MSUNoQVBldk5LN3ZPVFVw?=
 =?utf-8?B?dzN2cHd4NnBienZFQ0RJTkwxQmRPTVprUklhNXVsMjg0c3pFQ0J6SXdpSHhX?=
 =?utf-8?B?c3hFU3JUNlJwSnpqSCtGcnZLSFl3ZXRpMjkrWng3T2dnVmdXZkt0MWVvWktM?=
 =?utf-8?B?bTRkK3NDVGIvbkw4bHZDTW9Rekd3NFlHVHFtN2JoVjZXQm9aT1lyNFc1M2Iz?=
 =?utf-8?B?bGtwWGpKQUx1eUVYb3JOVWxjZlFad2szNlpza05lMlVyaTBSWllYNWV1cm1U?=
 =?utf-8?B?dGN3eTl2bk1YeDZ0OFRUYWx1MXk4ZjhZZDRCWVJjV2QxTGhVb0o0K2NFbGFR?=
 =?utf-8?B?RHB0WUhaVy9ncDRlNHNhM1ZrUytDSlJUbFhoY2FEUW5UcFhPME1YV2R5R3Jm?=
 =?utf-8?B?M1RqQVVxRGtsVTNBa3pjWEJLS1oxSWNkSGJEakxlczFoc2ZscS9iRXp4N1VE?=
 =?utf-8?B?TEpzREd5N0t3QjVSMjh6OEtDcmN0NURxdmp1V3k0cmpRUGRBdTVGcXRXSTVU?=
 =?utf-8?B?c0tPMUJZQ1RSQjdVdWh4WEJJMDNyM3lKUjM4ejVyUE9xUVZrL0FTTWx4bDJQ?=
 =?utf-8?B?ZmtjMGNqWmJVYlZaRGw1dmNXSU9HVVZ2cHFhSnJZd3kzV1dqTnNVdGhPMXdP?=
 =?utf-8?B?TXlXaW5MNG9wSjJqd0Nxb2lEZm1vRnhVYWxZNFF2Wnh6OVR6bitwL2djaWZi?=
 =?utf-8?B?ZVp5am96b3MxbnVWa1hqUGYyV2JDbzUvZlREKytYdU0xQkUrRXRSYjFzekJv?=
 =?utf-8?B?STZOZmNIZ2Z3OXJaV0ZqS1RtcDJhQy9BQXBSOW95cWZCQW5TeFBFMTJQMHk5?=
 =?utf-8?B?bUVEU2dwT2UyVmJNRjlyQnU1U1NuV21BMFNxc29zTzl0akdYNXZJZzR0VVlZ?=
 =?utf-8?B?YVYvU1dpQ1B3Q25veEFPR29jV2o0ODMzNHRuNHBWVm1nYjBrUmZVcUl2K0Vi?=
 =?utf-8?B?TlpGc2l0a3JUbDF1NXJWQTJycS8vWFhRQWtqYThCcXR2VGF2RU5mWXhSbTNt?=
 =?utf-8?B?UU1Bb3JVb0x2d2d1ekpuWUR2YjBOaDBIYW9tMDd6eUI5L0toS1UrYktiSFFm?=
 =?utf-8?B?MW0vcWx3SlpmZXd0ZkdwQjZTUnMreGJ4V1cwcHRkY1BhNlJJbXRoS0t3Mm0v?=
 =?utf-8?B?NnVVUjNTRDlmemN4RGdqUDdnb3BTZjFycmlYaXdXTkFnNFVGbDVMeWpkb281?=
 =?utf-8?B?ZkU2cGxYZWJLN1lXUmg3UDBFUEtXOXhYYlRwUnNmV3Q2V1dUQnpOVGNlalZK?=
 =?utf-8?Q?SqYkUVdbZeUlW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFlacGJKT1pqZ3dyZysyMDFqYWRFTjdkTVVSK0pXcFhCam5LeVY0VzBaQTJ5?=
 =?utf-8?B?YVVTSWZ5d1BQQ08zdVk1OXhSNE9SckhJcTRDOGU5MGxhaTVabTdhMXNJa1Jk?=
 =?utf-8?B?MERhem84T0hrRWlnWFFCWEhEMnRsQlU4WHVrUVgxTy9uMEYvZFBLR01iZmVx?=
 =?utf-8?B?TFVhZ2gwdDZaUkVSZVVzY1RGaXZNZWlhV1dmTGNSbS91NHFGZlp6WmM2NThm?=
 =?utf-8?B?bU5tTU1rbzhWT1hWdDEwdXNBT0tic1pMRXVNQ3owems2TklvUVdYbzRrb1NM?=
 =?utf-8?B?dnNnblViOXd6dlhGMVBZNFcya25JVlQrbkhDUklxWGF2bGMwaUE5Qi80cFZk?=
 =?utf-8?B?U2dLWTQ1Q00rcTBzWVdSMEtrZmZKekRrQU5EZ2pXdEw0N2RQZ25acUhLZVZY?=
 =?utf-8?B?R1NUU2pybnZUSXZLenMxU1VSSnZ1NEpZczdMUGxjUDRlWjd5N2lHYWIzS1Az?=
 =?utf-8?B?S2ZKV292WDd1Z29hdmhlNjN3NXdoY0F6cXhnRHdtM2xjYXRYNFM0WlprQlJr?=
 =?utf-8?B?cjRqejhaVFpwVUFjU21HMGgyWFZwVWQyK0YyRHNSTjlRaHViSndRclRKcWV5?=
 =?utf-8?B?MDVzaU9xcE1jcVVOTDViK0hFQmFHb21ROWNpbFNlQ1lGRjJ5eGgyVDZuQmJ2?=
 =?utf-8?B?T255WmErR1lqcm1IU2NPN09qYmFFZmJFSGpvVjBvZjJtV0hKZGF4Y0orY0FC?=
 =?utf-8?B?Z1VJM04xeTEyOThJUHRONzB5ei9JNDA3bk9neGFHajFxdGY4YTlXdmVkT2tH?=
 =?utf-8?B?MHYyRVlrN2RUTm1xN3IwQ1F4Yk0rUFpyYjhVYzZuNis2MGp4S0xjMUJna3NS?=
 =?utf-8?B?OTRreUQ4cnMvdlpQNlNNTXhSVkhqUElWejYxOFF0NjJUeGhBYW0zdVFWbFBl?=
 =?utf-8?B?d0Mzemx3bDdwZWdyeUd6c1NKRDZVYktlSDBFMlQyQzJTRElhZ3lzclFBT3BP?=
 =?utf-8?B?SHNHd1RkaEZtT2Ixdm9uRFlsTWh6KzBtNktCV2EyTzdMakg0TW12ZlJ1ZW13?=
 =?utf-8?B?eXJacFc0dXNud0hMODAvM0F6emVSMlN0Z2VzcG12aTJuck1lSkRaZlVBRVpF?=
 =?utf-8?B?dXZYVXRTMDBUUUUxSmZsSURBS2ZyemYrMzM3eU00S3ZWa04yYnpSZ3o4Q0wz?=
 =?utf-8?B?OWtabUZORFBoUWFHTk9QQytLYW1lSEpVSE5EdmJpZnVIMndvUUZSOGxhYW02?=
 =?utf-8?B?anRVY3JhNzlKUVQ3bUI3SjJHb05YUmlTVUFXQ1hmd0tqeFFpNW9naWpWMmdS?=
 =?utf-8?B?aDB2Ny9pdUlSanFaa1pkK3NvN1JxenhtRmdNODNBQWJ3YWFXaHIxeUtTbllp?=
 =?utf-8?B?YXJicGFvUE5yZnFVNkUxT0owQlUzeFl5bVlUcWZWSU0wbTdhZW1VVVUzcUUx?=
 =?utf-8?B?NE5GVnRFYWFhUFE1UlhvTTdFc2NIM3Z4bWQvT1ptMGR5WmNWMTFXU0JrblVM?=
 =?utf-8?B?dyt2M3pOWUNuOEVUQm8xanY4Mit6eHl5SHFTQ01GMTRRVkc0RzJDRmxic2VP?=
 =?utf-8?B?OHFDbFUyYlFBT2Q4OStrVlQxVlhScUI3L0FFSHdlSlBQc1FscjQ3a1dOQXJE?=
 =?utf-8?B?SFZaK1B3amRvTXl2dkpCRUZpeW9rQk9oRmZ4blYxbkU4ZVorY011V29JUXhB?=
 =?utf-8?B?ZFVCdHkxSEVLdG8xTXBvQ2x4N2QzbzBEaHFSeGMvdHFCbkIvRjNZSVM3ZXFt?=
 =?utf-8?B?SnZPRVlvdm9PNHUxZ0ZXTFpTLzZzcmJVWldZdktRbWRvMnF5YlltR1I3L0kv?=
 =?utf-8?B?VTFxQVJJT3l3YkpOWkx2dHUwT2xvZ0xTb29mc3Jidlk4QVZwakhzbXhzbFFn?=
 =?utf-8?B?WXJrRXNJQzNaTjBWUXFnbHJNOEZsV0pTckNQSWZUQUVST2hucGdFT0xmM0tv?=
 =?utf-8?B?NHl4VThXeUhXOEhvdy80aDRuVXNjckRTUHlxNUI0WEM2eFQ3VmJ4UDZXMGd4?=
 =?utf-8?B?QTdsZHBzOUUwaGRaSHdrY3hIOTV5N0UyeWNVbDNUeC9OUVM5cyt4OFpSMFAv?=
 =?utf-8?B?Nk1RUXA1SkJ5dkNIY2dJS0sxOGF0VmFzUGR3OHplL2Q2eUNrQmZFVVNxNkcy?=
 =?utf-8?B?aU1VcWtlYllMeWFoRUppUy8xWWdiMTFtdjlXSXBLTDBHc0F5Mk8xS3lRK05Q?=
 =?utf-8?B?MGdXb3hmckRMVnB3eGRRVVp2WEZLYmlJV2NUcHRiem5DOEd6QXAydkkydlRC?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29995fdc-956c-40a4-f6ca-08dd33cad1db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:07:15.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yOHgprEwYQCq420lEMsJ5Va+4gLsNjqjmO9ER/aLvQy6AXEEEu5Q0knhsMyql+x2gA7q6X5qYWeIs7EX4fbLPsLGyK7lUkeHP3b8RrWzUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk to handle a FlexCAN
hardware module integration particularity where two ranges of mailboxes
are controlled by separate hardware interrupt lines.
The same 'flexcan_irq' handler is used for both separate mailbox interrupt
lines, with no other changes.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/flexcan/flexcan-core.c | 24 +++++++++++++++++++++++-
 drivers/net/can/flexcan/flexcan.h      |  5 +++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..3ae54305bf33 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1762,14 +1762,25 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = request_irq(priv->irq_secondary_mb,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_err;
+	}
+
 	flexcan_chip_interrupts_enable(dev);
 
 	netif_start_queue(dev);
 
 	return 0;
 
+ out_free_irq_err:
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
-	free_irq(priv->irq_boff, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_boff, dev);
  out_free_irq:
 	free_irq(dev->irq, dev);
  out_can_rx_offload_disable:
@@ -1799,6 +1810,9 @@ static int flexcan_close(struct net_device *dev)
 		free_irq(priv->irq_boff, dev);
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		free_irq(priv->irq_secondary_mb, dev);
+
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
 	flexcan_chip_stop_disable_on_error(dev);
@@ -2187,6 +2201,14 @@ static int flexcan_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		priv->irq_secondary_mb = platform_get_irq_byname(pdev, "mb-1");
+		if (priv->irq_secondary_mb < 0) {
+			err = priv->irq_secondary_mb;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 4933d8c7439e..2cf886618c96 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -70,6 +70,10 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
 /* Setup stop mode with ATF SCMI protocol to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
+/* Device has two separate interrupt lines for two mailbox ranges, which
+ * both need to have an interrupt handler registered.
+ */
+#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
@@ -107,6 +111,7 @@ struct flexcan_priv {
 
 	int irq_boff;
 	int irq_err;
+	int irq_secondary_mb;
 
 	/* IPC handle when setup stop mode by System Controller firmware(scfw) */
 	struct imx_sc_ipc *sc_ipc_handle;
-- 
2.45.2


