Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D201D7397C3
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFVHFj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 03:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVHFi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 03:05:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442BB1BD1;
        Thu, 22 Jun 2023 00:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYWBogu/nHfSMdymu+pgHgoYw0E8rchN823zGtF7+6/03Y+iH9PWxFOyoAlN09IZEpxFIs1jmkEeWZi69DmFbW1C4LzBe8ItRjsIIiLCnKhRNlB3RgIzvtbfFNb2wGRfH4D1LaZAx0s85Xu6NGBgXCWGmg15MawSntLCerNs2AOP0v3dxuhsJ8LkLAU25Kv2B6bACW1R8e8GDGvhMg4HMhCn5+FEhUf8US6z+S7aKzQ/ZenxjJkazuty4vpV3D6Aa29juKWwMqYuERBSUi+5XWGn0FgCXInMbMLULd3psYYw0+MrAvBI30wEEaqrnSu3OmEfLyYnporUZk3Q/ePaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTqXagykzy3ued5EeX7NGEh9/C/D08S1E5v1b1a6Etk=;
 b=PR9cDMBDhYxwXLdq9mE3HvD4ldg9z8jfzozD1ZLHvjPqDYlcfV//H6jQvp8c9UL9vuPX5VRO94xaRwc14CUYBWuDslucZX8eSjV5LqBWPVUxp99PM3MfVbp8ckgbMBaNQPu/pFH0R8jaJRgmm5sZVrVp4yhqILpsLs2OrjqSHxhu53gVKLbdZV+cKxYcqvJ6ea+hYjJoMQ02CZFtnk0x2JR7RUNVuz1ajoIm/M0PsBy5D/8HIPZQis1DVS4EnGyVxJj/eJMf+JCG/2CwomFu7HRLH0KIMs8hhtULLqX9Jo6XlVdRc9m/CU50t1auCxD0/eAI1oBLpf8VNyqiHmw9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTqXagykzy3ued5EeX7NGEh9/C/D08S1E5v1b1a6Etk=;
 b=CorXqmKx2MtJLuLL4wJgC0ynC4sUc5cLX+mJujc9vmEl0g02vmAKNUdWnqLM7s6cG5EIn9fW8afZ4hCfUl3sHgnIPy7xM1heO5d8vOg78PbWyfpv135tP1RTjoZlHPFgl985kK7cUVCEencJinMR0/vTddm6K4ZuEqepQ7FoqYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ2PR13MB6331.namprd13.prod.outlook.com (2603:10b6:a03:562::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:05:32 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 07:05:32 +0000
Date:   Thu, 22 Jun 2023 09:05:24 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH net-next 04/33] can: esd_usb: Replace initializer macros
 used for struct can_bittiming_const
Message-ID: <ZJPytAFaG3UFaw3i@corigine.com>
References: <20230621132914.412546-1-mkl@pengutronix.de>
 <20230621132914.412546-5-mkl@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621132914.412546-5-mkl@pengutronix.de>
X-ClientProxiedBy: AS4PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ2PR13MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: a910130b-8bf3-4cda-46f4-08db72ef1165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkxJzuZjpZDX248wnZgIVxOW8oINdK5WQoR1jq3/Dyw0zfwCF9PjkIXCwy7JXg5cRM5fPjUzRfDM+5JqUXGAK1df3GtrgXWzHo5tiKwgUBjLo/oAIqNfHMbn85x2xHQN9/7tLk7ZR4WEhHq5Msd1sc7mKuAi14YA+enEi8PZ6Z8kYPx2WG7wa/rY6qtFEDZ+2XFnONm/0Evr9o/+3tbqc0Ovf3qa+WVOxs3QnTGc64Lt6IpzanVrSYjiQm2tuf7i0bEWKzRYjyn8+2jMISQ/fXpQjLCAHsqqEzB1EBOSO/AXunxBKhruAh12oj6bJpdFSTb5iAxEHpXNFGMNrZ4JCVwaSnaKFjTpLjxNAdlCPjVWZmYB1A54vN+LpSeTTMZilRLaUXD3b7TazUpi10FT6E6ro75RX/PvffGY1IHt02kQSRsBW58b9QTya1zETnXsleR7AdUE80rjVSJVoX8aQn4vknl67ycaHHVNTDgrHbLzeFJuVay6p3arHt38U009KvE+afvPUauWn2i+oLMYbCm8Ee0WtGYS8F/jamLTakLnI9/u6InP6Ulct0wsEqDcj3caUhGJ7XmDZv3zt0MlSp4gIq6ooduUMz70cmcHoHddgXABw7PDQfNBW58oZmVA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39840400004)(376002)(396003)(451199021)(5660300002)(8676002)(8936002)(186003)(2616005)(966005)(316002)(6506007)(6512007)(2906002)(44832011)(36756003)(38100700002)(6666004)(83380400001)(6486002)(66574015)(41300700001)(4326008)(6916009)(66946007)(66556008)(86362001)(66476007)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LEU6dihSnF2c0uPZYePSJMjplpZQ+FS7j/8+mO/OZ1G3wQfTH3fYwfl4Q3qC?=
 =?us-ascii?Q?ukrByGfKWq0/Ep0ROgNvxlx1aDrzPd4JLpV/+MuS1ZbQb5IVQKPEEhR4Y46j?=
 =?us-ascii?Q?mCmzk8RmQ3Phr5gbg01keRm4RDWWTMY87pjFZpYDXJb8RYmQY/dCjBmFfoZ2?=
 =?us-ascii?Q?LwHfmTz9GfCsbYEo7P/4D7ZSalZOfMjEoTNQveh856fHSawv4pvaVLpqO6xg?=
 =?us-ascii?Q?6WQX2qW6QTYJUKgU251DF/5JOQrWKKKtJ4ME3r0lgRKtQZHmXvml3s+rtSdZ?=
 =?us-ascii?Q?JToNm12SuSGh7k0IzDZ1DEPJpHTVBmmqmhCsxlQy2+AWIrt+Vlenidut/YhC?=
 =?us-ascii?Q?jdlqheAi4NxYW6fDjevSOUOgM+IBa3EGvg6Aqzvg/aSD/DOV5TbUcSpBRKqQ?=
 =?us-ascii?Q?bgCsnURpZJVPEeCLwb6x9J/hFtCJXexSfp+PelJK5ly2yWzyaYBQBHzXdwCF?=
 =?us-ascii?Q?9I0469X0maqLu0e35djjYg1LtaA9V6voNF2koa0OHaUQB6dARvMuDkLlc/aG?=
 =?us-ascii?Q?U3q+PI2d352xVaLHm5IfWniDuZfl3lB1dL5MSqexZqC3yujmhSiGWwURdYbK?=
 =?us-ascii?Q?mGQVZajXv3DyQFZkZetLRpAzwaWYRxmmIM8PuCM9yw2yzxauut098GLnZ5Zv?=
 =?us-ascii?Q?K27F+2Idz6/gvUQNPJND1SloWRLuywx3C9/50kpikQjKGQ3eyII7/70I9CLd?=
 =?us-ascii?Q?8HS8WKhhLBHvfQtTLPxYMPHM56X7Bt/G2xKb/0adLfzj9jff8mumvlbZUMXp?=
 =?us-ascii?Q?EHDR93dahFUfuDpuJ+bwsOXSJhJFRNioAyR8U8BGhKE4GQASXGkTy2JSGhTp?=
 =?us-ascii?Q?SASYX6pFt5hR6i4vmheXf7LoiEL1vwVuMpP9N/26+CuSdAU8mkk12N6RR/xq?=
 =?us-ascii?Q?jAavbhjXluyNmg3PS0xc6vxyPA2XeW6P/CBPu7HqMzFRmNu2Vbjfb4PFnVAW?=
 =?us-ascii?Q?8lFIcqAl3N60THAUbVg4JXWEBB7iayQfykh58lyE966wzPiYO6tiRVLMk3rE?=
 =?us-ascii?Q?MaVJ/p/06zYPNF3MuDY80oiAzquz5IvWx0OsejsTRwlAn1t6gKhvtMtUCLBw?=
 =?us-ascii?Q?tOHmPgn59afK3DlQc0lisvfwwv1fUoEMILKQ5YrPC00RXwx0rwgXIcjuT7Ay?=
 =?us-ascii?Q?vswIM4xDEmW7SX9yc+dycAM6/UGv+yt2Gya0f1CoSZmtGq2YN9uo7YD/MkkF?=
 =?us-ascii?Q?AIbkgif1ccTYHk0uehv+dTKt/6DfK1G6IN3WjcHiPfDN/gSCOVFuPhlMDhMA?=
 =?us-ascii?Q?JBOXOv52W8IjOtNGQxMCBVix35OnLiKvSYyaWUfZ8x0OreIWa+t4M5ophAst?=
 =?us-ascii?Q?WddkUVdYLKm+QIZacVhktW4PjCknGhH+rOGlCzG1txKEGDbSXeRCzIWlp9Wi?=
 =?us-ascii?Q?CjJnMFZGh0mGD1AsZ6jFqhf5U0Bnf4aDhGsaRmwC4/PG7/fw9O27+6kx+D/6?=
 =?us-ascii?Q?F3o6SD0Uh61kR5AZdSi9Nigf30kY1iPri7t6sS0HK83Z20GQRHmqCOorgfvf?=
 =?us-ascii?Q?9LISlz8p1Ntj71c6cWKUPBKatz944eEiGlkANPV01ZWAtaeI7154t8i2kMhV?=
 =?us-ascii?Q?ZOAXsQIztjCsI0aGEX1jVg+5MjxMh7hv91J4jHht4sE4PmSQxnQE3lvX3H/H?=
 =?us-ascii?Q?dkiZFGGap/kRPBCD9hom5kC6B0lykgikdklxZVrSmI8QnTGj4XJ6MMsUpJYD?=
 =?us-ascii?Q?vMypJw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a910130b-8bf3-4cda-46f4-08db72ef1165
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:05:32.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PILsSmODDg8GZODhaR0LGm+pUj+1wphDAj4yyT1nj72ExEe8cMbAcbzpw8+ldp+vpNfjQeplqj51NZMDd34nnXL4PZbQw2FKHLSRFP/e/dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6331
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Jun 21, 2023 at 03:28:45PM +0200, Marc Kleine-Budde wrote:
> From: Frank Jungclaus <frank.jungclaus@esd.eu>
> 
> Replace the macros used to initialize the members of struct
> can_bittiming_const with direct values. Then also use those struct
> members to do the calculations in esd_usb2_set_bittiming().
> 
> Link: https://lore.kernel.org/all/CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com/
> Suggested-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
> Link: https://lore.kernel.org/r/20230519195600.420644-3-frank.jungclaus@esd.eu
> [mkl: esd_usb2_set_bittiming() use esd_usb_2_bittiming_const instead of priv->can.bittiming_const]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

...

> @@ -909,18 +901,19 @@ static const struct ethtool_ops esd_usb_ethtool_ops = {
>  
>  static const struct can_bittiming_const esd_usb2_bittiming_const = {
>  	.name = "esd_usb2",
> -	.tseg1_min = ESD_USB2_TSEG1_MIN,
> -	.tseg1_max = ESD_USB2_TSEG1_MAX,
> -	.tseg2_min = ESD_USB2_TSEG2_MIN,
> -	.tseg2_max = ESD_USB2_TSEG2_MAX,
> -	.sjw_max = ESD_USB2_SJW_MAX,
> -	.brp_min = ESD_USB2_BRP_MIN,
> -	.brp_max = ESD_USB2_BRP_MAX,
> -	.brp_inc = ESD_USB2_BRP_INC,
> +	.tseg1_min = 1,
> +	.tseg1_max = 16,
> +	.tseg2_min = 1,
> +	.tseg2_max = 8,
> +	.sjw_max = 4,
> +	.brp_min = 1,
> +	.brp_max = 1024,
> +	.brp_inc = 1,
>  };
>  
>  static int esd_usb2_set_bittiming(struct net_device *netdev)
>  {
> +	const struct can_bittiming_const *btc = &esd_usb_2_bittiming_const;
>  	struct esd_usb_net_priv *priv = netdev_priv(netdev);
>  	struct can_bittiming *bt = &priv->can.bittiming;
>  	union esd_usb_msg *msg;

Hi Marc and Frank,

it seems that something might have got mixed up here,
because GCC complains that:

 drivers/net/can/usb/esd_usb.c:916:43: error: use of undeclared identifier 'esd_usb_2_bittiming_const'; did you mean 'esd_usb2_bittiming_const'?
         const struct can_bittiming_const *btc = &esd_usb_2_bittiming_const;
                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
                                                  esd_usb2_bittiming_const
 drivers/net/can/usb/esd_usb.c:902:41: note: 'esd_usb2_bittiming_const' declared here
 static const struct can_bittiming_const esd_usb2_bittiming_const = {
                                        ^
-- 
pw-bot: changes-requested

