Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7A5A45D1
	for <lists+linux-can@lfdr.de>; Mon, 29 Aug 2022 11:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH2JOq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Aug 2022 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiH2JOp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Aug 2022 05:14:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C315A88D
        for <linux-can@vger.kernel.org>; Mon, 29 Aug 2022 02:14:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w8so1218614lft.12
        for <linux-can@vger.kernel.org>; Mon, 29 Aug 2022 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=xzMPDG0QlD/mkARyeafTeA/NKs80T3AlUogaT0+ZKBQ=;
        b=PlK1lwvqeAPo05uf/A0c31vssHbLAJgw3/pp6TIcq/QnJWOEk9KQym+Xh9f5Yc6+3K
         FcZ1XTmv4iFozFOp8UhdLOZdKFvpwyWSlKQn7LWaxQc5TNJudbVTMjZP3XvlGH3eZOo4
         gBXWUisZaatcynoQMSqfLPSfWq4h8q60+nBwLjRYWrZSIYaxZGzrm5wi/VB0qu3ORHYI
         RYEQaChQRROCGi4FQY3+K8EzgJ0MwmiZ2l5zOSiLQmyAlOPsi5Mo/gV0PvlOVSap8Xbm
         5j8pkH/e7/VFZkiYIzNG3ly4Yc71Nj71xFtXhCQLEigSGWPAotEvaLNp81QYJcRLit8D
         avng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xzMPDG0QlD/mkARyeafTeA/NKs80T3AlUogaT0+ZKBQ=;
        b=sBSguzeSb+Py/BAAeWJtmnzaIsezPaOkI0XMVzFDTrlK6ruLF45HJcMAqhE+KcpkbO
         IAGh251KqxduJC/fv8Pd3UPjBq7+uqUSpelpJa8y8QAPlo/aMD4zzQFQ8Le2wyvce2oK
         Ysvpc255RpVL8yEIpRk+i+94ZMpEhgzs/Ni/cvV1Cv2v/zYVjt2ZG4EvNnxpKmu3y7Zf
         jJcPQo9z+NhW6MK+hsu7WE6ImcMVhnsd8NPeanaKfXJj8MRzcIURzoBw6CEnWUVb2b69
         wKuBnSn8MoiNeiiwbQg/SrcvkKB6r3bFzK8xZRL/X38rECV0sO2CqCu6uvL/Ee0A/JQl
         FgjA==
X-Gm-Message-State: ACgBeo3v4RsAO2r/hwaYapeVssOxf80H+J0BQ3MYGmIDMTDZ5M0FMEIn
        gN6LkUrPMcl3971nwW7TL0yocn1xW/CUOg==
X-Google-Smtp-Source: AA6agR5Y3nClo9Ev1h4Lw0C5NFeN1kpHfjlUWabszNVvqt/PPan7K/IIJhteXeAwDitf+9eK+HlkXg==
X-Received: by 2002:a05:6512:3c8b:b0:494:618f:ccf2 with SMTP id h11-20020a0565123c8b00b00494618fccf2mr2816265lfv.657.1661764480281;
        Mon, 29 Aug 2022 02:14:40 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id t14-20020a05651c204e00b002640f967acesm567558ljo.0.2022.08.29.02.14.38
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:14:38 -0700 (PDT)
Message-ID: <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
Date:   Mon, 29 Aug 2022 11:14:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
To:     linux-can@vger.kernel.org
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
In-Reply-To: <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 8/26/22 13:24, Jacob Kroon wrote:
> On 8/25/22 15:25, Jacob Kroon wrote:
>> Hi,
>>
>> I am using a CM-ITC board 
>> (https://www.compulab.com/products/computer-on-modules/cm-itc/) with 
>> an application that uses the CAN interface. After a while of 
>> successfully sending packets, sendto() starts returning ENOBUFS. I 
>> wait a whole second and try to send, several retries, but I get 
>> ENOBUFS every time. I'm using kernel 5.15.59, and I've tried both the 
>> pch_can and c_can_pci driver, but both show the same error.
>>
>> In the console I see several of:
>> can0: can_put_echo_skb: BUG! echo_skb 0 is occupied
>>
>> I've also tried to increase the txqueuelen to 1000, as suggested here
>>
>> https://stackoverflow.com/questions/40424433/write-no-buffer-space-available-socket-can-linux-can
>>
>> but I think that if I increase the queuelen the threads just block 
>> forever in sendto() (sockets are opened in blocking mode)
>>
>> If I bring down the interface with
>>
>> ifconfig can0 down
>> ifconfig can0 up
>>
>> the transmitting does get unblocked.
>>
>> Is there anything I can do to debug this further ? Any other ideas ?
>>
> 
> First I get the print:
> 
> can_put_echo_skb: BUG! echo_skb 0 is occupied!
> 
> then netif_stop_queue() is called from here:
> 
> https://github.com/torvalds/linux/blob/master/drivers/net/can/c_can/c_can_main.c#L469
> 
> and then there is no call to netif_start_queue(), so the bus hangs.
> 

Switching back to the pch_can driver. I'm guessing here but it would 
seem that the driver is not receiving the TX interrupt for 
'PCH_TX_OBJ_END' that would wake up the netif queue, since with the 
changes below I can't reproduce the hang, although I'm still seeing a 
lot of "echo_skb <x> is occupied!":

> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
> index 964c8a09226a..75ad2272d9b2 100644
> --- a/drivers/net/can/pch_can.c
> +++ b/drivers/net/can/pch_can.c
> @@ -719,8 +720,7 @@ static void pch_can_tx_complete(struct net_device *ndev, u32 int_stat)
>                           PCH_IF_MCONT_DLC);
>         stats->tx_bytes += dlc;
>         stats->tx_packets++;
> -       if (int_stat == PCH_TX_OBJ_END)
> -               netif_wake_queue(ndev);
> +       netif_wake_queue(ndev);
>  }

Jacob
