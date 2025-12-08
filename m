Return-Path: <linux-can+bounces-5829-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B1CADACE
	for <lists+linux-can@lfdr.de>; Mon, 08 Dec 2025 17:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AE033006E36
	for <lists+linux-can@lfdr.de>; Mon,  8 Dec 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C471B21E0AF;
	Mon,  8 Dec 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B+iuf5pA"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A191D9663;
	Mon,  8 Dec 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209666; cv=fail; b=N/uV7l2x8OZkayZ5j3ExocLC4kDeIw9ZUzPir+HsZvmv4b9iefvXd1Ct+slkuK8p/c/2F1sPg8KvDpgSEYcby/WRGmwyYwuyu570+zkHUp85tMUaKPMc0IbiGWUhfMAuT5odY/mRGGSOR+asXPZFj1kxusan2iAAoZ6ze4cA1+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209666; c=relaxed/simple;
	bh=ZNxxwmbHKwpkbKB7NtFA7YRb4Eq3yK5ToN09aG8tKUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ihMXY1p0Pjf/5RdnLUAWNZyuHUqL172qqHFYf+qmHX8wxaVnCN3FVvmDfCcnX10daNXDYxIej0rwk0MeNM1WcUn99g64UMN06lFZ9KP8FZMqlKWLTznpzKO/SZoxfDXDbOlLfKkbZWPh2nk6x28/HyKSuZpP7jZwWyrg4ysgcfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B+iuf5pA; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2Y8uz8drOBbRLaMitqCAWnq7G8Mh5J8n2v1L4sRz/2+XxGLr69XT0sRWkSF8kZxdmRVIU8VKzap+fG9YNc3rwWIo2datgPAc1PWJZu7cZHKix0cl9NTI1pD37euZPEbFyy31MNB9fHkR98Dt4w01Q1GlYHGKotkMo+UtaeEINd30MWeVP1h12GsTUON9tPFFzVmTrY+0QU7GLQzpCjd8B5dbt54Ahrmfv99ppwaoG+BVeejC//9PIRT6wOIdiwrI+wjWoi/SpX09Ezw8qG6NhAL2Yg0UDTlndeKxGftENOAWZtrsxYYBp3wSQW/p+IPwvU5PtCA7zxCVcc7/sKiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXL23Octa3iHFpAAIy6IwP+6zVKwn6lk0Ggs27tGchU=;
 b=f7rhQHDLTJ3uNSIXCPJQzpcZK7sceDHPXiKlRlgvYbKo97ScF8wKmwD+Xgtv5ByTpsliboEFibFYdBLZ1EcNZWcryb8zi2gNGrIrTyFckzZA0C8qZ14DvYdgtm+kVsFMMB6zy5rTGcj735iABOOziu/6vnuErjlKTpiMHs1mgqqh8V7N7DTOmOiDHpMVr48Eyuj+tHtF64EDIGw3PW8DVzTrkD6HriLcfcdBOgtqCh6w84H4K/W2BhjeB9A/rJjt5cA+IBa/nDCxNys7HYHe8no65v3V15YFQ26zvLc94r/TcRm9y4w8koX+geB2y5L5WHCKo4XwlQ1PwVpAgG6wBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXL23Octa3iHFpAAIy6IwP+6zVKwn6lk0Ggs27tGchU=;
 b=B+iuf5pAyIpK4HoWF+u0rhgCxr+scisFk4hzF2Y36r4Ct8W4e6s4kzQLoHwT/xriZq7YV2A3MBLvi3TM0wR19djkWo8d6Zy99FOSoRvaLX3NcJUqD4+bybLJlKf2j09Wxw0o4OTcdMfrXgzeersmBx9VbGog5fAxi0v+BT09pBVClTE8cD3JHSYkPswwDqpyQ3aJo4YjdGc/HLAAtry1olgQwfHxPhA28OtrDxGaMZx4Mma1JNLbJU2OCLbEEfHR0RhkPmcwNPcoq2h3ZQvHjv4BvUkLQY6AFHVdK2PS2Tjtpoo0Bk/JgvzP8Crug7S4hvFqG2SH5EOeV5uYWQ8yxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAWPR04MB11707.eurprd04.prod.outlook.com (2603:10a6:102:509::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 16:00:58 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 16:00:58 +0000
Date: Mon, 8 Dec 2025 11:00:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1046
Message-ID: <aTb2MuGSZvp9d0Al@lizhi-Precision-Tower-5810>
References: <20251208155019.136076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251208155019.136076-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208155019.136076-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-ClientProxiedBy: PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::16) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAWPR04MB11707:EE_
X-MS-Office365-Filtering-Correlation-Id: cc30f23d-25ff-46a8-c5ba-08de3672fa0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nvQhODSCJLubpqNvugV3b697uNwnQOqTqDReNkI7OpQNpMMYk5unShZv4Uj?=
 =?us-ascii?Q?RuTEwulShy4P+gevxN3+eg2Bew/dM14fn5DCwRxjmN8fGlzaI0BxcbGvuon+?=
 =?us-ascii?Q?UrEYfqGPwCMIo/G/NucndV2jbcIdRUfKMiiJWdbCn81CmaElFTz17WJKWiyY?=
 =?us-ascii?Q?hf3fT4DVYnL/h3RGF8PozoEqtZhHWmQ3mhczvCvMPbfa1uDMz1qlQMSaJwSk?=
 =?us-ascii?Q?IAsl4tmASzBLeR+oyGspVpoupPOrkHHPNdvjCvbsydGawL+Q+b3+5dMmanQo?=
 =?us-ascii?Q?KdZBwFCjpt+Oz0amShJmdHmwpVa40PnM0tQ59Ex0FgEwT5nsBGaHhRm8bvL7?=
 =?us-ascii?Q?KTzWW5oXy66/R5e64L8VmEiNiY0e8M+mvH6Vo4LUSHKIGSXU4Jxabk+uspvo?=
 =?us-ascii?Q?mwydDMQ+A6qbSaQougQQLHNaL+Y4WVKyxGxODh0GyQ968R5X84c/d4Hn04UX?=
 =?us-ascii?Q?1jwMHizQ2uGbmSdQfYLr7e5w97a6n02RpH/+wKiEsrIGdrQPclKRKTxwvW/F?=
 =?us-ascii?Q?uo45t253jKd+3j4J8pKrc/+/NGzzdmt81DGEbvllzvb9lz6dngjePuipVzDf?=
 =?us-ascii?Q?sCNpOFoM+ieA/EfmHDIA4MSL1I38i6bE9+QPxnDn/ffJPa2Eng/eFitj+/Yc?=
 =?us-ascii?Q?ZbbQgwQWLJL4eH0qcK0hp4z35RUbhN46Ro34B2u/3EcdUDrMo0FjQpZVhh1m?=
 =?us-ascii?Q?YLH4H78b6jyxU18zprUG65y8s4AD/WUQlAyMLzbRvV2/YRm6TFRIVib7PrQj?=
 =?us-ascii?Q?GG1rtQTg+/yYpZ4auUHC13YP6b4GewsPyh1IvwJWPcxxl/2vaD6O2bZxL6x5?=
 =?us-ascii?Q?Y9GK8gXOdYDnuupB23lZHoFaknay/b5cQIrdo6oRTEwbd72rnVVMJ1FQHPPG?=
 =?us-ascii?Q?o6JH1SvOguQCgtRHCk4iA81qGwJb4r5JJ+zjVoHuS9aIV7LXHSp9lz6g8UFR?=
 =?us-ascii?Q?uYt3UIzE1Uy9ZBLvEz76xEVglzJZTvf1SusUr+fDhgS2lJJY2i722p285/t3?=
 =?us-ascii?Q?SF4bEWmTaWMAdtFALHqeNGVB2gCdLPbP2c28fGMg5ignKe2gBr/gSQ+2e8HX?=
 =?us-ascii?Q?RbqFk82Kr1FD8LMo5PDfZG3887BlRxAVKnNoN+R9Sj+EMCq7ucoKaieMlvL/?=
 =?us-ascii?Q?9rlW+KFgqpu+9V8pg1VTtgYCNNYsyXyplgtdxCukfMUFBQGWhwqS3SnrEZCS?=
 =?us-ascii?Q?TUAhAEzrkTQA6rzPYiBN4rKVFYtfDA5kI2GGtTLMHdLUolUJJlexBDAwRzhf?=
 =?us-ascii?Q?CR+nipKsUcyGJs+eBh/Xqo3LJ/YTsF0BSafV4WpsnS5XP64oxTQX4RFyFHIn?=
 =?us-ascii?Q?La6VJrUMIto5MIWilY+c75fp03dnyab4uLSKotm2ordYx9jOq/GAKeEZ17ZC?=
 =?us-ascii?Q?D7D9R/VCrGDTS1GuH685rkDrWLDwhB4msV364DQcUIalP2IoqtXbki+/woWk?=
 =?us-ascii?Q?GzDihs7giRWHA3a1Rh9u3gFL/Fo/rMKbx7tH28HngTgfqEoooRje3LqIPNEU?=
 =?us-ascii?Q?ZXW4iuuLW4PrZggBDNjXh7E9o0UVdnpzcwe0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvS73LhQqbBAuDxsTGRLcydK2ByA45nArmRl8RlunWTyoP0hVxEWur3PrKMd?=
 =?us-ascii?Q?hJeFVizcyWK7SCSFIha1cy8WuaI/Vf1yV4JZqq7KkzXLAnriETUGOT+3A2cp?=
 =?us-ascii?Q?s3Udb7fZxAKGth6e0z38libn04cS+3THxHBXwWt1Jkftncxu6hL+hP7eFXvE?=
 =?us-ascii?Q?ZXY2DnQm2jUWFKdH8fsnuCTQOiQ+DDEbpkd+7eH1t8TUVP9EjK5tlir+wmzc?=
 =?us-ascii?Q?iIVHjRSjKL25JApI3HdKpELKmn2ny/wGn7C0sEI0mLO0OBcS6ST/NffQI86a?=
 =?us-ascii?Q?GREUmQnm2cSIUpv8TXvFfF/p0uoc58l77k1s0wTSrZu4mN4a5geSizmVyyeY?=
 =?us-ascii?Q?JH9e68I7YPH7Y3/jkohv2kgUtv7PABzRV9yTysBNuFv65Q7JCMZE5EE2hPTa?=
 =?us-ascii?Q?IaBNr1J0DI/F5VAs2VJM382QG3ZkjXLEzHS++KXVaevTWzbwDUyilyHXoo8p?=
 =?us-ascii?Q?cOMFUw02SCbVm4UktcCC4N9E9AX9u8Pawok2W527fGZTTPlrEl6sa2+o2s1q?=
 =?us-ascii?Q?R15maPK6ea+ch8unvywc2mMPxQVYF1XT/KJDczbaYUhPBpSN/3T5wbq7OMeK?=
 =?us-ascii?Q?ipx2jytJhVGtLSgkIk6F7mJPcvUCZfmoMGF5BC9jdYz/mnwiRwaBIPOeJTXc?=
 =?us-ascii?Q?QC5nqzYicL+UXKt5E9/SHQOxVsHA8ubCTZvqSA+Bd+9IpQ8R1hzd7v8YHLxd?=
 =?us-ascii?Q?iRij9kElKGpEu9TdSLoyvqWCtFNzKJBPTQXAcBBmkgQbptOEq8/HgeT3/4S6?=
 =?us-ascii?Q?5/xOLtFWmZ10tCRX4qQJtqKC3FM3qYhlMkzgHSRRGH9XBMy/vnJqkjxbcnLC?=
 =?us-ascii?Q?g1Hey5Prt/14jzidHw2/TVoMXDEVPVu9sNzcXT1gSBDV0aW9u9aci56Gw82A?=
 =?us-ascii?Q?OQ0DJJoiPPwv4mhHQPUH6Pvs4wwVl/JA5sosUbkOywTT6o4NqX12n4enR4xI?=
 =?us-ascii?Q?MKkwFcciWdP6ViKiofEiicqlnnhHqB3p0FLi/Ufr6ATqbW1dUILDCtad57dk?=
 =?us-ascii?Q?bREMl8VqpY65YR2dXgA6tJNvuW9u2JKYL4E2SsbPfYAfZz6skmouyPiaTnsH?=
 =?us-ascii?Q?IMQgCTKlzsDK6hGFi/C06Ypy2eVUhb3aehDTCgBFJMowQ0TYCXfHnGVYrgYj?=
 =?us-ascii?Q?exE6zz4gFvcJDwrVUscfDbpZm6hY1axi4XYcACOCAPBBy8oVFTuN/vTzDywe?=
 =?us-ascii?Q?xmC8VWWe++WoJ0Tzk0Kl5H+jyvrMtFuEn8wB1Yv/go7CNkLqPT3HVw4EhQ4a?=
 =?us-ascii?Q?lB+wJZD7EYX/zObZLs2xB2MMJaGdbRkT+4JFTSp+3bmFYX98aDWsq5g9xmlY?=
 =?us-ascii?Q?gukNJ19Uut0hacn7nUfobySFfDDml08YAAGcoOdPU49sIWcfw9GzSrckSeuN?=
 =?us-ascii?Q?0f4lEKqjaxDW6LmwbPUa3uYDsXZ0f0hq5/7xPpFZSTYWynFm3+N+xmlGbV+A?=
 =?us-ascii?Q?wYZpwOTk/PlWB6Byq4S8vdnlXDaSCG6SE4ucZCFkfhzUXhOsgNCeiYPCT0a4?=
 =?us-ascii?Q?RaUIIQvahgHHPgXicayzT2A7Zi01gLXWPab+MqRj6sBJZYPiJADbDJIv0Kl6?=
 =?us-ascii?Q?zVFCIiGKmnteHd7Ut3WtnZi583S/hTgaWB8LhHm7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc30f23d-25ff-46a8-c5ba-08de3672fa0d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 16:00:58.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxJ7NqgA3zJHqGk/yUrtEkqID3p+g63Z44pCxbaKjRbrhmybiAs/XcyHZ7w+TyE6zoiNCXV8mGyy0Ert1cK+Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11707

On Mon, Dec 08, 2025 at 03:50:18PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046
> provides dual high-speed CAN channels and includes STB1/2 control
> lines.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index c686d06f5f56..c53c4f703102 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -23,6 +23,7 @@ properties:
>        - enum:
>            - ti,tcan1042
>            - ti,tcan1043
> +          - ti,tcan1046

according to patch2, which is the compatible as nxp,tja1048. why not allow
ti,tcan1046 fallback to nxp,tja1048.

So needn't change driver code.

Frank
>            - nxp,tja1048
>            - nxp,tja1051
>            - nxp,tja1057
> @@ -84,7 +85,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: nxp,tja1048
> +            enum:
> +              - ti,tcan1046
> +              - nxp,tja1048
>      then:
>        properties:
>          '#phy-cells':
> --
> 2.52.0
>

