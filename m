Return-Path: <linux-can+bounces-863-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E6918762
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2024 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17301C20E4E
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4218F2C6;
	Wed, 26 Jun 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lQmoW3Cj"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2063.outbound.protection.outlook.com [40.107.103.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122C14532F;
	Wed, 26 Jun 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419395; cv=fail; b=K2jb1mD0ikqpQRukiimIoRbGSToMmxEMatjLATZWmWjEBK5vUcKnCl3EeiUeXmOF9b7JAku+iumYos7Bl2Lp86dodbX/53GnHFCL5u0vwHgXoIRPqLeJOUW1TG8pZQbc7jj8eL/hx/kaRAsLkp3U2REUyY5Mk6zdx4/InHa8j/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419395; c=relaxed/simple;
	bh=eUeGOBGpzhiJgmEdRi332ihnrV6Um2OQD2geyDZ5NMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WiJivBxfZ7Za9WleUMk6SusnB8S8xd53+zxVvU+uGJ0XNKEftWdRz2vR1QtPfM1/o0r3eJh6bEDzrPKnITF8Cw7FXSbnEVN6Va7uYPAaB3QWnMD0mWGIB1TbyVl4VbJAA7pbj+c5q7MWw88hNw1cprZ7XBvAWR+qc18OeACr2tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lQmoW3Cj; arc=fail smtp.client-ip=40.107.103.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWeCDIs+zmtsidTJ068gBcSR7R00eifL47TyCMgdBtP0oAHPS9m+eKGDwH8iwSgU8ldAFCr49NsRggaYUjQHLqK87ICmgKEQiuFqZZt2Ys06NIiXZSZf6sd/RS4d6tT+bl3Np5sOZguMI9s4tcUK9jQBHIx6K9ykraVCqrWDAAQHA3mJT0w8ZZL59dS2TxzwgMQ1hknky1W6r9M1mmB6TAChUuETk+SOjkXqstcWb3D7IwzSpRQQZjxlFyNbWhBh+fsL7SMpKNz2tRMNSLZgVmcueL8ydxu2bG8a9wvpP7eGnDxEEKQR013ara9mK1Eon17JdDewijC+V2ZTXTa7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK46UDzalx1InLyEaZbfY4z4HsBd59Leru5iZslN0No=;
 b=aAE00/ZxKVXcUOm5deen7DHG2BvPs+Ohh9C0UMgvN3MvR19IyossPkjj3AEH6l+YnUQc7Mq4nnbtCNuTPLTJyG21VZp0nu6G8z82GgYh9AudKqqTuJwEmei8vAvTWEOQyURa80duEym2zMGXG5HjoqjYhKS8eBKZ1ErjA76yPRIv93k3UbjoPBpKmEoExAPQ29VhCaEpHzEL12rXWwt6QF9aly8+v9/wu4jRbzZ/s1PNNyh/plfbDOEc99Y4hyH4Df3K2kaWM2USpGmArIQnCRy7YnZb0Twf1tqADfBa0w4PTnQ9v/iKVzWWifUH6xc8ZcHgxNwBmfvTTZidv8kDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK46UDzalx1InLyEaZbfY4z4HsBd59Leru5iZslN0No=;
 b=lQmoW3CjSoUtJk6UUFwiFAss62azXRHVkJORSDzFgymMQ2wle64ahmE1HBlr/92mX6ueG5QuXifkG39osXYCsuKu5BkPGvZ/nZzFWqx3T8gfn/sFltQgbj2Wpx3lrfBw6t0DUk7BkvtkmQQe7pO65rfDGD/0rXMVqAZPmX/oBg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9584.eurprd04.prod.outlook.com (2603:10a6:20b:473::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 16:29:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 16:29:49 +0000
Date: Wed, 26 Jun 2024 12:29:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: can: fsl,flexcan: add can-transceiver
 for fsl,flexcan
Message-ID: <ZnxB9FxYKxx5MZhx@lizhi-Precision-Tower-5810>
References: <20240625203145.3962165-1-Frank.Li@nxp.com>
 <12853a72-190f-4aeb-9a2f-4fdc42c9e4df@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12853a72-190f-4aeb-9a2f-4fdc42c9e4df@kernel.org>
X-ClientProxiedBy: BYAPR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:74::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1536e6-867a-4e2a-71e9-08dc95fd331e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|7416012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mnt30lKIJ5a25iiUFEcMAtVhKtW/X5wOrlkvpX7/lRP3FPr4vEEpZLBxrDf1?=
 =?us-ascii?Q?AExPYiM3IYXnXOLpTRkHKw+75l1YBrhuqQLS8qXrtYQI/AP2kpnGyfxTWp5T?=
 =?us-ascii?Q?HJAxDP2Q/wUKYkhkOlYaBJGX+QyTJLRg3rYiaVdGs5Kf4g/fwvAwAPSUD5Zd?=
 =?us-ascii?Q?C2VqMliUkFORNopPR0ZjDpXZoEY5FRrCS8mhyoRjKExxqB6x9qzbvIApEh3B?=
 =?us-ascii?Q?WEiK/lZrzABW0vH48SEgy2oZc6w8Qi1v7dPFfTUYs7mmUxCyNo5KSC6mJB0f?=
 =?us-ascii?Q?tDUfGYBVBKr8/6s8/2ft6tVdDm1bPOYKA3eLORREAAVv8ZRpS89XiHgmqi86?=
 =?us-ascii?Q?nMwW39HJWm3UEsYH199NMvNZiEmQ2DB3nxb3irpv5OKrGzOZ/WbRxtwKtBQo?=
 =?us-ascii?Q?qmt/vZkaZ//RKxwfmephgpObjt1VosbM5P42tHaykzZEh896yHhpGwhoqOKG?=
 =?us-ascii?Q?3WWOytdiiIn6OOgIeIwWkxT/kRxp3xIYRFEGjzq9QxEJJE9H4E5mgOiX57iN?=
 =?us-ascii?Q?3eQcyLc5niYiaKwYf2QNnUOnPVLRkGP6zk60RUAOtXLV7VymU5JMk+U3umFa?=
 =?us-ascii?Q?yYglyNfcA81rheRE2GD8VcOSg5DdB4IMaCNfYI+IRwWh3xGvOI93OPeEPMrK?=
 =?us-ascii?Q?GjloYLuWBCGGN7g0VCuEYiRqG4RqHlgrVLOnQgrP03MrNzpMHzD43P0bOAas?=
 =?us-ascii?Q?Fvt2jbOU/g4yfe9CqRuN3XM92SJdCKtcL4cPeHnpa9iO6obzYgfxZOj3+3dE?=
 =?us-ascii?Q?Sn4wbYi4yDcVTyuBCeSPrVMPdE1HVAolDh0GtBXfIpimRbWtZ/crJYO0PmT/?=
 =?us-ascii?Q?KfnXBps06gE2zekUAET52XkM0WfJxVUKQQF/XDTvdedAL7OrIT7NHHHtvLnu?=
 =?us-ascii?Q?x5a2FyfvVFU4qjTi3qMuzGY1qTeUI6jU2celCPVxmbk99ybyIpwToX9HzxwB?=
 =?us-ascii?Q?d1SmGq3w5Ywl0W1Icrphv4ZrENQE+vVyzgPdNT1qnX05CDQFrNciYxiKGF2r?=
 =?us-ascii?Q?Cl+NkZu2kHJOfNj1+ZxYr2b5OyNOfHOAEgSulUiBu4NF5snI/WjmbjbofqPb?=
 =?us-ascii?Q?V8QYgqrcqQVze3E5lVZXar2fevunjbHfyjtIrj1LmSWRVrRXAnnAA/AcQDAQ?=
 =?us-ascii?Q?v1X1YcZ1xjPytfSdt9/APdlUHRHqmsq9bzyZMhCcv4759bCErDh9LKlAUhHi?=
 =?us-ascii?Q?gQfRs2+/VPgyqkHcJTW9KLrzR/EiHa4Mh9BFdM5PhOb87RP6ICSH3NahlWCl?=
 =?us-ascii?Q?P/bN2vJ7h/qCGvkitw2gj7adP8QgxpmmIiwNYwQjLKAt+b7RMiaJXaVgZCUM?=
 =?us-ascii?Q?Zd/A6kJMrqK3Knr18YCtwtVlCYZvUORtDjROsYssiG0axU+lXqyG07uNSjQX?=
 =?us-ascii?Q?pTkbHSa8UQQMYlPvRJR3P1JqxdaDmAACEhpzvz4rEw085x26VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(7416012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSwwPb+ge4oQc/8RmEuv733u4njpal/S2MdCMwaqAKIXqqcWYqr6kT42gykd?=
 =?us-ascii?Q?IfbhUXvlqRJgII5scaPktYxRuP7g+4u3wzu3RT1fDOH31jmHya0g3aF2RQ+V?=
 =?us-ascii?Q?uxk8xhvT2MfmQHLqRlaiMh+lILlqtrClFx9lUkE9Pa00l1+VBlnsWtA+7n/Y?=
 =?us-ascii?Q?fyC0HjvPxUmxbRxPGLzjMfRZJISICTF+E5k2YLotYwymiEPGk0Lcvhcc1+hN?=
 =?us-ascii?Q?ZO9Vcii5daIsDZXTz1sODbEeN8KghDl3rfXs+endiLIdFaKx6YpKmT0WTV5Y?=
 =?us-ascii?Q?8/KjvAARLWjY9bjWhp0KIKuBEMhbuVh3l4ywbV1sgHRgcyp/ECnRG7WItmiA?=
 =?us-ascii?Q?6m1PoMlyaWgdcsk+AraNVn+plooSzFyyji1RiOAVim6u7z3biKH1/ZyWmEIk?=
 =?us-ascii?Q?COmYhfDIlyTvfw+PfnyF17sweTnfD7zWPueJzCV72NG1PGHCdgMQeoT/AH8D?=
 =?us-ascii?Q?xzJifIn/N/A+k/FJ60MhDDZpPBWoB5FgOuE8dWplbA0EdpwfgmhZrD6jAdRX?=
 =?us-ascii?Q?4hKXmxIZ8LBdUGIzNv8hMocPUHPK9TjAML0/9EaWMkI7YrAXtEgRUrkf+fiw?=
 =?us-ascii?Q?gyWxquL5E4FmnVdfJx/ra7ure0EtTfn1CW4DLz7+jIfSsy8VT67DSQxMlZ+N?=
 =?us-ascii?Q?oyXrldZXMtNMITv01bDsLveCHrMTX5mshegC6D9MB9uDbyxqbNFr7K8xYBsP?=
 =?us-ascii?Q?MY/hZJcEyaiDj82H5XAkaC9UepQGM/e8yV6Lxv7fcUCTfKxnsFcYI99UDUrI?=
 =?us-ascii?Q?ILoB1uXI2Lq8V/jGYaozHyLuFzwMmUdZW2rBDejlImTMcot8pWkFF9m8WHdf?=
 =?us-ascii?Q?8/5b5mIXZtXidXosJlMyjXheEIPFNmipiHPdYLwYylRv+28M/lvqpAtqZzbY?=
 =?us-ascii?Q?6xYjPuadn4VGBTm+OVTjLDPNC3gdfGVdV2gEOFPt6L0V0IzwqdmAh+A6oY8F?=
 =?us-ascii?Q?QS2rnXcqqaxsIxc+0yzbhfG2gpnvOfgbYGjfMQp6ISZlYakBPBkTwIa+S2A5?=
 =?us-ascii?Q?Vouwu0hTeUlNTuCP2he1lt27vLY4Hp1GtPYSPzuVDW+sypFyegKClDgllBwT?=
 =?us-ascii?Q?ctSIRa7wLk5umG21Dx5GV+0bKjHQI+zwZFPnPgHkYnW4zH+3ewNuM4GKkXgV?=
 =?us-ascii?Q?7JX0sbLFdRdkQzjV/QU0TKuk3zoMrUT6x6TBm7+n0pxu578zV3Y3cn3PSwTj?=
 =?us-ascii?Q?5aoN+MCiDJCrZuIS+5kFOWCqlCxppF6tvG3p332RsYWbzjKONwPrOuDI5aPn?=
 =?us-ascii?Q?bJhn5RMkO5NZhti69DUJtl6pZNwVohDERZG2F+t0wEkljN3ugzyyGaDEsTl/?=
 =?us-ascii?Q?a167d+yfizDWUtpz2BAhv1QSD6lIbhio2rCyDbzHzv9KqxYG2x/Ye5oVvwQm?=
 =?us-ascii?Q?WmtgRhwzHd8LwOQeM0qg896oo/xd2qffXMrZtgzgMonTyIWANZyEfKER8AIM?=
 =?us-ascii?Q?aA5YlN3a9i9UmUIBeufPdKiWh00+xTZ/CtI1QAQHn4lrVUyPlUcvihUvhKYP?=
 =?us-ascii?Q?mIayFsIJ2wpBLK1IFnh4b0lPdcTZNfZksA46FzbaAdpvRZxfWROwj4W7uSyf?=
 =?us-ascii?Q?xnUbbJFbPkgtVZNbdbJk+wI3mZA1hUemE60tfzkW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1536e6-867a-4e2a-71e9-08dc95fd331e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 16:29:49.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hbOmLxLB28zf22Y3r7pxd23mqwrVLDgYcQ/Be20H3wShhV4qY0zxCGh5xdx04mrX70kiAJzIgMXLbbAlJw3Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9584

On Wed, Jun 26, 2024 at 10:19:56AM +0200, Krzysztof Kozlowski wrote:
> On 25/06/2024 22:31, Frank Li wrote:
> > Add 'can-transceiver' children node for fsl,flexcan to allow update
> > can-transceiver property.
> 
> I don't understand.  Who and how updates can-transceiver property? What
> is can-transceiver property (I assume you speak about something
> different than child node)?

can-transceiver is chhild node. dts like this

&can0 {                                                                                             
        status = "okay";                                                                            
                                                                                                    
        can-transceiver {                                                                           
                max-bitrate = <5000000>;                                                            
        };                                                                                          
};

Or, I can simple said

"Add 'can-transceiver' children node for fsl,flexcan."

'can-transceiver' should be common child node for CAN node.

Frank

> 
> 
> Best regards,
> Krzysztof
> 

