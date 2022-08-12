Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B4590FAC
	for <lists+linux-can@lfdr.de>; Fri, 12 Aug 2022 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiHLKtI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Aug 2022 06:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiHLKtF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2022 06:49:05 -0400
X-Greylist: delayed 117 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 03:49:03 PDT
Received: from mx-relay74-hz1.antispameurope.com (mx-relay74-hz1.antispameurope.com [94.100.133.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B1A99D2
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 03:49:03 -0700 (PDT)
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay74-hz1.antispameurope.com;
 Fri, 12 Aug 2022 12:47:03 +0200
Received: from EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 12 Aug 2022 12:46:57 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (2a00:1f08:4007:e035:172:18:35:1a) by smtp.eckelmann.de
 (2a00:1f08:4007:e035:172:18:35:4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9 via Frontend
 Transport; Fri, 12 Aug 2022 12:46:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUUCCx+knFqYv/0JY3oFmgRiLr5WTbkLbG1+SoA60xQYgUSzetRk8olyaMUQqgQSaoUel0tpOxW5+8RGAbNv++VOF88uuqIdp/C8s6+4T6dsf1KjANLW0nok6UdJjwyQ+nlDnO/tGrqIvL1yLj9LwhqvittyHux0ZzQQytqHGO4TkMcXr3T/CbHW7HneGs7sgRc7/+Enh9aVAUFyl/jeJgQl4E0FNeT0ofyCEMcGWiRa0KFLBaZV/Yd+dcnSdeVzFgXp+XGhgtfeNVNukcRo/jbMR8DdeLCrh5kNseOKqWzHujUnxD0tnl85+F18cIygAzYOgjqtgV5e3kHXGHp98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hdgd6hHzjcvS3e3MclNCWSEyGPLWse0Hf2Z8PzVa9CE=;
 b=FarOq1MZ6hry+JeOgaufnnevwUXqYKWiMD/kipwILVeLEwMUbdHO3Hoqps8jd4YWPAnAVDjSEOXwRmzQARGOFqHPraKAkN134HkOMvFotpYAJyfZXNj5lOabzyD7vkAubcr7c6vO9UOyAn7DDf+z39o12hIDPXX8tVFgXVjH0b/Yuyt1ArlDrKUlIl6HksZgIHNKeCVN2smZWQKn5OSp9FJX4R1QTqyrI6sqU0DVYOeUZbxBDQrWBCRZUowthgXc6hlNZoef0iPWCMv7iA1FI1n/RpZ7Pwv1T+EGxJtcC23R4QHjDQ35/DgOmVgRPn4fCeh4qyrs8JQiLt3mgzMXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eckelmannde.onmicrosoft.com; s=selector1-eckelmannde-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdgd6hHzjcvS3e3MclNCWSEyGPLWse0Hf2Z8PzVa9CE=;
 b=vVPpE3BlG4e3xD7zcCuOchD66CAYOmPGWqTTo5UjxVTt2IRm+/X2ZcamYqGKVNVaw1kmUMskl0TDIaU0ZjOQYPG1DJsZEj86n8BBZpjbQBlUXvWPEyEJyzJF8I2gB3R354g85Zzw9F+lb0F6pb6UWaeKvZA91jaS2otXWv0euns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from AM9P189MB1700.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2fc::15)
 by AM7P189MB0900.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 10:46:43 +0000
Received: from AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 ([fe80::5dbd:b598:df28:90df]) by AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 ([fe80::5dbd:b598:df28:90df%2]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 10:46:43 +0000
Date:   Fri, 12 Aug 2022 12:46:38 +0200
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH can v2] can: flexcan: flexcan_mailbox_read() fix return
 value for drop = true
Message-ID: <20220812104638.b4spriz4jwhdskxk@NB142.eckelmann.group>
References: <20220811094254.1864367-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220811094254.1864367-1-mkl@pengutronix.de>
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:2fc::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93600ffa-4c0e-4529-d46e-08da7c4ff1f6
X-MS-TrafficTypeDiagnostic: AM7P189MB0900:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zrtqmGjexuJLSLQHWW1RscWB3+feAH2sGcft52uhhTHCyJiVn7/10jsSK7TP5c655qxTWBfJQUcSwBEZwhvzEbwRj/JAWozircBPdAYGFiKv+qdrRjPzFXqBct9wBbJOvWmZbrHDoOK5vhLDbm6Dr3E4VDut0Pk7L5h0rRnww3ZvA5Vv/Rpn9YsIiHgL/FHCUfNAnCeL8HacuCvP3ZVODL+38nf3/nIWVyAqtvr+HlU/dFJA3/ZN6dNyYwhcKzAsHpQuRUhUz2SPCtBIYoev9pPRHy3WrGfzv9FQIBjtudkT1fPl/8FJI2g4CGIjLB1A4GwZFiBYkZmCqtsO2inDQSpNU7GoV1FvhwUoO6TzRaj3+dahQX48TFrsrlvvmlXxjrfVo+4J1kPBGu5VJkmaGzyxMp6AkFQp1fLfHxIuTRcQQeotWF+uATKq4yPNB6is5rkmp+JCwVmSGJE/VDOrt+YJg3POjMXCoricyFwwTXV+zsbqGywarr/Br5HUltmlfmTuymRMZahWCQM55NrShqdQ1cIxkmcoloqCjMsd49GCXEm8escCGaRyoHlCJWuz0XPfTAhwvnTLEyUqXAkpR3ZFARAgCDHonXNpyptdoO4mLFoHVn17kklz1qx5GDki2QPNlX+BLR1h9mLzlmq3eEx5Ie4sWsZT0MAyWDidbKdhqbs1c7hu8uBETP4cxziy23F1/FoUGqPYsOVAU8oo1RdEmT+QOBsYloGe412du+KlL1pnlfan12PqlyJj8YGnhGm46/OtwygXxG0Nq9nZuhCrDQQSH2jJLiaQvFWJ8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1700.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(376002)(136003)(346002)(396003)(366004)(38350700002)(6916009)(316002)(38100700002)(66556008)(4326008)(8676002)(83380400001)(478600001)(66946007)(6486002)(26005)(86362001)(2906002)(5660300002)(8936002)(9686003)(6512007)(6506007)(41300700001)(6666004)(66574015)(66476007)(186003)(1076003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1hfbYVPobwcDfDMxbJzPzHzksuYu/NkE3vfEtJtvo1UDhnQewz4Ry8hpla?=
 =?iso-8859-1?Q?KCpcgYHN7vvpZbUqYh/ZLpJUYFUPIy2/dyKXe7Vo/PDCQ28fikht+UfpC9?=
 =?iso-8859-1?Q?n6D5B1Z0ABje2Ivo47bQ65YQrx5hGDleuoDdHMAq0x9iRdfYdCLz7oZCW8?=
 =?iso-8859-1?Q?1DUVILAYTkE83sT0rd1WILJI/h/gmgxzvXraczxaMhTmjxGJLiEtGHD07z?=
 =?iso-8859-1?Q?Zq9wBX1lMNvC7R7pm8m1LI9FQJxaAW9yZoeDv70+whpQXqEAU142t9Sk3P?=
 =?iso-8859-1?Q?4X4Pk7N7VMxC3a6GyorC70Qee8aWvmVeEPvv8WTEKiOxYod6fX8XgvhBGN?=
 =?iso-8859-1?Q?tI8Amuz8SzmS9r3QWZFFJL+ldGLbHkXy07ocU+U2oMZvu17fP8q2DUWZ5b?=
 =?iso-8859-1?Q?JlP9QseuQ0sLxztJQJPAJAWlSga9AONpsK9H55HUPGn8eToaT+z19r81+8?=
 =?iso-8859-1?Q?wJbj757nsGQvr4p4MFRIERoYxxzLFEHLR13xZ0ICACLtd2X1yb3pXSvsb1?=
 =?iso-8859-1?Q?uaX/WDd9IYk8P9iLxxEc0GI3ma4DA3OVEdHxM+I0ak+rfSIVVqf8o/gfoU?=
 =?iso-8859-1?Q?Rd5M9KDkfHmr3YA/wzIUR+rCain5KRrb8h74edfNpZ5uhrAYmQt0HKQ9Gv?=
 =?iso-8859-1?Q?e4wvw2YwVhLKGBSfaJ6NehBIM5s2Z+w+A0Yt8DUCcajNimYTdd18ViI+n8?=
 =?iso-8859-1?Q?kXax1+8qRSw2w54pXsv7mcGFr+HhAmsfUJd3n5bQ/FOYRWwforWinyAayd?=
 =?iso-8859-1?Q?zbVKEbr9A0JSnZ/uhZohEFgX8izqIkDkU9HbFb9POEzkpwWtNmkCj+ZHVe?=
 =?iso-8859-1?Q?V8ab0VxH0OAG4dxx/wTmlaUHXFMJXxezpknTmbMRlq7xsMkaBuvRUqh7fL?=
 =?iso-8859-1?Q?p/SH4iQGym35hItEkevLNNQJPUODcv5q3mAzVGx/rnmHutQzyFAj1kHF9+?=
 =?iso-8859-1?Q?JUgNSMf/gf13UDOjk9/JfjAOSxoi6z9p+3w9mwCLUc1P1UczoFOZY+YsWS?=
 =?iso-8859-1?Q?669bpib5m3/tG9+BvmHPvEJ4uDjeEsHovBHCmzR//lZiUlTI1blp/U/f3H?=
 =?iso-8859-1?Q?7DsoxFtZZTH+HVh9fR4e94GqQmEPieo0Z2TLVhrT0xlu98TGZjuiH7i/Mx?=
 =?iso-8859-1?Q?eKgjwOn1Pj/+z/RAL7qGhWIPvTTsngW9UzfZLWj7OsJZ/QbdQCOpE8elJ/?=
 =?iso-8859-1?Q?AnPo0vxtXTK+03ikWTroOZ+4kaSBaYqLY/Vx/PFsIJUDyCXD5Qmgm+0JR+?=
 =?iso-8859-1?Q?iZYKRsZeoH6QzySLlLLbdNsWeWjRUvZHoGGfKrCoI+LcCkaen9F6Ybm5FP?=
 =?iso-8859-1?Q?lqYVCnCZWjxM8j7LKWAaq3Lc6pfk8ZL2cqYWpA4Nz9FymrHnzeFJ/ufhl5?=
 =?iso-8859-1?Q?s7CQ9rVwaSn+BhQo/laHahnxMcX6nDOi3gZuarb6ctzXLhfXfnkXTS/eiU?=
 =?iso-8859-1?Q?WfqKRMD1pQ3cYzRPfC3+iNMyxeSvCQ5ctCIOquQW44XRrOlWItl4XtjH0y?=
 =?iso-8859-1?Q?MwromS2Jyl8uBgxmGny6dqaFv37fKCW29Y5JZ5g4FJqv6Ecj72rTparr2X?=
 =?iso-8859-1?Q?SEKCua3rU3YPLKRtm1GnyMO6B80CIpXnV4cUnaHz+krUTrT3keqCg1geXN?=
 =?iso-8859-1?Q?fHEBV2KWeR/t3nsyE1wAuLSNNuGeUyoG1tjgHrOLz1QHDuXydUs18n5w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93600ffa-4c0e-4529-d46e-08da7c4ff1f6
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 10:46:43.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/hBxZptAsszEZ0Klq9MRTIr11lNQ/Pa3tbCjhvTIMQtA9k5Kuq7ZLLzVnt7Aghx8N4YvwzyJkpkM/BXT6GRug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0900
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-can@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay74-hz1.antispameurope.com with 18EE4708DB2
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security-Digest: c7d8657ba0d0ee4fb27d8a335b621002
X-cloud-security: scantime:2.096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=date
        :from:to:cc:subject:message-id:references:content-type
        :content-transfer-encoding:in-reply-to:mime-version; s=hse1; bh=
        QoaUj3FFnyr2kOXVd5UucHFm9JxNf2Jka6d/pUDW7mE=; b=GGYPw92CcQP0ZOu2
        n07UOJ9+icEYaTjINXMmL70QFELL8KjceJn3HnCh8wP6XYPvGVbYx/Wd/5+RWPJi
        dU8S4xZsXtEyXJr+0dHOTsrxaD1OvfdzZ8A3BW0Pw42jq0u84a8+rd9Me4DWM39d
        pO3QIM5+A9meMgKbhdzFo/bTtDYTmXQ34YI/iVEyqo9AlgOkCv9Bbp/Vx/d4yVxH
        Va3sw2R6sSFKYHQ+9TdXRkuYSm7OFOocVPisrGMVAPEGHQ4HXGe4BxwebxeGlLzY
        3IiLBCyLMFJKsrHmlpLhl4uxe9bbUoMI1CvfB0wL9DvZg4UL8KaXJ1AfeNqV1bgB
        96u5AA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

On Thu, Aug 11, 2022 at 11:42:54AM +0200, Marc Kleine-Budde wrote:
> The following happened on an i.MX25 using flexcan with many packets on
> the bus:
> 
> The rx-offload queue reached a length more than skb_queue_len_max. In
> can_rx_offload_offload_one() the drop variable was set to true which
> made the call to .mailbox_read() (here: flexcan_mailbox_read()) to
> _always_ return ERR_PTR(-ENOBUFS) and drop the rx'ed CAN frame. So
> can_rx_offload_offload_one() returned ERR_PTR(-ENOBUFS), too.
> 
> can_rx_offload_irq_offload_fifo() looks as follows:
> 
> | 	while (1) {
> | 		skb = can_rx_offload_offload_one(offload, 0);
> | 		if (IS_ERR(skb))
> | 			continue;
> | 		if (!skb)
> | 			break;
> | 		...
> | 	}
> 
> The flexcan driver wrongly always returns ERR_PTR(-ENOBUFS) if drop is
> requested, even if there is no CAN frame pending. As the i.MX25 is a
> single core CPU, while the rx-offload processing is active, there is
> no thread to process packets from the offload queue. So the queue
> doesn't get any shorter and this results is a tight loop.
> 
> Instead of always returning ERR_PTR(-ENOBUFS) if drop is requested,
> return NULL if no CAN frame is pending.
> 
> Fixes: 4e9c9484b085 ("can: rx-offload: Prepare for CAN FD support")
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

This patch (rebased onto v5.15) fixes the issue on our i.MX25 board.

Tested-by: Thorsten Scherer <t.scherer@eckelmann.de>

Thank you!

Best regards
Thorsten

> ---
>  drivers/net/can/flexcan/flexcan-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index f857968efed7..ccb438eca517 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -941,11 +941,6 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
>  	u32 reg_ctrl, reg_id, reg_iflag1;
>  	int i;
>  
> -	if (unlikely(drop)) {
> -		skb = ERR_PTR(-ENOBUFS);
> -		goto mark_as_read;
> -	}
> -
>  	mb = flexcan_get_mb(priv, n);
>  
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
> @@ -974,6 +969,11 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
>  		reg_ctrl = priv->read(&mb->can_ctrl);
>  	}
>  
> +	if (unlikely(drop)) {
> +		skb = ERR_PTR(-ENOBUFS);
> +		goto mark_as_read;
> +	}
> +
>  	if (reg_ctrl & FLEXCAN_MB_CNT_EDL)
>  		skb = alloc_canfd_skb(offload->dev, &cfd);
>  	else
> -- 
> 2.35.1
> 
> 
