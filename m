Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC9E5A26D3
	for <lists+linux-can@lfdr.de>; Fri, 26 Aug 2022 13:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiHZLYO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Aug 2022 07:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245049AbiHZLYM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Aug 2022 07:24:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B0DB070
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 04:24:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m5so1609681lfj.4
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 04:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6JXIIeiVMsOHHZcBbHkSOh3mgWOPqrpq/P5dQ/v8d2U=;
        b=g2lkleB0ezWTtK5zuw4jmUfuTiuRz46lvuqnwOZnUfKy7+G+eaLYDIitxXsg1vmAYo
         5wGiAQvxFTAS5XELis/7+aOXpueGm6QEkXFRTloTXJMTeestP0sUgPkhcCkULfMg4Url
         KkaZhsL2sztaIVWIFp1xbrSSDA0Ktu8KbFZEGM8Hc6/o7G5J/qtVET89+/UqJ3NfRY6o
         lkoaC3K4UOw7L7ezi+BDrAGCAYM5nW7YEi1Rg0qZf9h/eo2jaBTzQeSG2AH42zS0ULLT
         jTXetiSu5aTDZirD3tqTXlDLQh+3zNAM6nSfMjrYmxZfjM+8PaSrfayPrxVhFl/DBdwC
         kIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6JXIIeiVMsOHHZcBbHkSOh3mgWOPqrpq/P5dQ/v8d2U=;
        b=20wb2y6pXGZKMXyoUb06sadgrrKszSV+91xI/DsxeiMVEQZ7GoWx2x5JB9Awwv05Vb
         TP8K8vBAQl1PNAkRWNRl2Y4tTFumvn1VVpgoO6KiPxDIJz3JeA6S9QHy7KbwnDT+cr08
         IqO/hiJQ8zumxGb1LLAxGgaJZTaHkYawVtE0VBPYb7LiCmnt5rKMyJJfb5PfDSU0vg+u
         9h7rouzvkUQiXyi4jTmB033pvh4hr0IFCPLtXduDTWN1bVPq4y6Gnf1XDjen52CKdYNA
         LUKOrvYvCh+quRLflqqoUirzoHdrW3R6xsnnkdrJSbIMzG0Zl0pF8YoqLa1d5bjeFF79
         VJMw==
X-Gm-Message-State: ACgBeo2aUXtWrsmJRJH2V4bH3C2UZPdO5cgp5tYpFbkf7xyZMq9JEH+Q
        U9N2aZfT3pgI3d8Gij5afd6kqBbQ0GuzUQ==
X-Google-Smtp-Source: AA6agR6OjIDqgfRa1/s9eslvuBlBGDblnU2m1BbOnv+24RzOI/SCrcInQMc3d0v35LtSp1wVO0xytA==
X-Received: by 2002:a05:6512:b12:b0:492:8943:c813 with SMTP id w18-20020a0565120b1200b004928943c813mr2242111lfu.143.1661513050017;
        Fri, 26 Aug 2022 04:24:10 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id u15-20020ac2518f000000b00492d064e8f8sm344971lfi.263.2022.08.26.04.24.08
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 04:24:08 -0700 (PDT)
Message-ID: <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
Date:   Fri, 26 Aug 2022 13:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
To:     linux-can@vger.kernel.org
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
In-Reply-To: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
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

On 8/25/22 15:25, Jacob Kroon wrote:
> Hi,
> 
> I am using a CM-ITC board 
> (https://www.compulab.com/products/computer-on-modules/cm-itc/) with an 
> application that uses the CAN interface. After a while of successfully 
> sending packets, sendto() starts returning ENOBUFS. I wait a whole 
> second and try to send, several retries, but I get ENOBUFS every time. 
> I'm using kernel 5.15.59, and I've tried both the pch_can and c_can_pci 
> driver, but both show the same error.
> 
> In the console I see several of:
> can0: can_put_echo_skb: BUG! echo_skb 0 is occupied
> 
> I've also tried to increase the txqueuelen to 1000, as suggested here
> 
> https://stackoverflow.com/questions/40424433/write-no-buffer-space-available-socket-can-linux-can 
> 
> 
> but I think that if I increase the queuelen the threads just block 
> forever in sendto() (sockets are opened in blocking mode)
> 
> If I bring down the interface with
> 
> ifconfig can0 down
> ifconfig can0 up
> 
> the transmitting does get unblocked.
> 
> Is there anything I can do to debug this further ? Any other ideas ?
> 

First I get the print:

can_put_echo_skb: BUG! echo_skb 0 is occupied!

then netif_stop_queue() is called from here:

https://github.com/torvalds/linux/blob/master/drivers/net/can/c_can/c_can_main.c#L469

and then there is no call to netif_start_queue(), so the bus hangs.

Jacob
