Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86534D2C8B
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 10:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiCIJxY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 04:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiCIJxW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 04:53:22 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D29016F970
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646819540;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Sxyu7pT0DRtQyYtBI30fb6eG2ccUMgFn+gbNaI/zgwM=;
    b=j96B9E70Mz1UQEbQtej7VMKCSgQ6dJmDUAkRVC8wlivj1ujT4mZbwECAHQOMavkkel
    1qe3EeAbq9o/VutYgZM9boTTU3tnF+HxFwLZ7HnBpNxERDgnLPVTuSRgXN1YMcl948nN
    x7GjhKOJhIMKkZPMyYGvx8W21uRCVIF2sWJYBkaafCwtqECFH9MraLyP17+/Xtf8XLVA
    dswyLY1jw7JYIUG7OmgZGZrEgh+MIKxFD3Upg95erd+r/zA0Ok9EGOKQftPg+Mb0CXaV
    X2K7aPIOBTU6hnOknCVu3nplT/ZkvD3EJD7LbBqZIJCioWvrmgpn+Fn79KsZoITwL8O4
    nx8w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y299qJDlO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Mar 2022 10:52:19 +0100 (CET)
Message-ID: <c493eb1a-4d4f-a21d-a0ab-2d2117c540e3@hartkopp.net>
Date:   Wed, 9 Mar 2022 10:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [can-next 2/3] can: isotp: set default value for N_As to 50 micro
 seconds
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <20220306193454.33158-1-socketcan@hartkopp.net>
 <20220306193454.33158-2-socketcan@hartkopp.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220306193454.33158-2-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

I had an additional idea on this patch to prevent the unintentional 
setting of 'zero' by common applications.

Will send a V2 patchset including all my (five) suggestions for can-next 
later today.

Thanks,
Oliver


On 06.03.22 20:34, Oliver Hartkopp wrote:
> The N_As value describes the time a CAN frame needs on the wire when
> transmitted by the CAN controller. Even very short CAN FD frames need
> arround 100 usecs (bitrate 1Mbit/s, data bitrate 8Mbit/s).
> 
> Having N_As to be zero (the former default) leads to 'no CAN frame
> separation' when STmin is set to zero by the receiving node. This 'burst
> mode' should not be enabled by default as it could potentially dump a high
> number of CAN frames into the netdevice queue from the soft hrtimer context.
> This does not affect the system stability but is just not nice and
> cooperative.
> 
> With this N_As (frame_txtime) value the 'burst mode' is disabled by default.
> For testing or (preformance) measurements the frame tx time can be set to
> zero by setting the frame_txtime value in the CAN_ISOTP_OPTS sockopts.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   include/uapi/linux/can/isotp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
> index c55935b64ccc..3e6e20028969 100644
> --- a/include/uapi/linux/can/isotp.h
> +++ b/include/uapi/linux/can/isotp.h
> @@ -140,11 +140,11 @@ struct can_isotp_ll_options {
>   /* default values */
>   
>   #define CAN_ISOTP_DEFAULT_FLAGS		0
>   #define CAN_ISOTP_DEFAULT_EXT_ADDRESS	0x00
>   #define CAN_ISOTP_DEFAULT_PAD_CONTENT	0xCC /* prevent bit-stuffing */
> -#define CAN_ISOTP_DEFAULT_FRAME_TXTIME	0
> +#define CAN_ISOTP_DEFAULT_FRAME_TXTIME	50000 /* 50 micro seconds */
>   #define CAN_ISOTP_DEFAULT_RECV_BS	0
>   #define CAN_ISOTP_DEFAULT_RECV_STMIN	0x00
>   #define CAN_ISOTP_DEFAULT_RECV_WFTMAX	0
>   
>   #define CAN_ISOTP_DEFAULT_LL_MTU	CAN_MTU
