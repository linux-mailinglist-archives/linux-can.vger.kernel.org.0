Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1086E6A60BB
	for <lists+linux-can@lfdr.de>; Tue, 28 Feb 2023 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjB1UwA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Feb 2023 15:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjB1Uv7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Feb 2023 15:51:59 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DBC4680
        for <linux-can@vger.kernel.org>; Tue, 28 Feb 2023 12:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677617516; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CB9EgKqNOL0FrAgMILwWl/8CGxjQWwWN4GcugFZnmXkdTAsihCWUFw77Ygl4umXely
    7W8PqsG0xsGxH+ep/uknBhbRRC/Sc0iWbP83oMH9LeYyRMaRdbUdk27l353AYsWjCWOy
    v16DnZW/lbWqrwb9k6pkT0KjewJEzOJ/xiqr9ogoSG5fnGzxk4dEsK/jARUxs1MjKVmk
    zJ5WnqI8IQeDudbkGsWtiBvd9QiGw1ar2mfPfd9PLplcM5zYlNlIxn0dNJlQx6EpC58N
    7YvKSr8z/ApbZHUkXz71jCxQnG1sDPIVSpUulJACEjzLE10Ff2kLV8FzpxZrSe4yVjhj
    En+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1677617516;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oz4kY5q/g3qcm+X43NvknJeXnZXMWW1IWtdNSGAt7y8=;
    b=FltbC9E1B71dWwlQLDBfthuHXLK8L6Tvco/nHFcv7OLSdkfHGhgzY0du6aqWyn4e/E
    dBIuiWflwrBerA6zrl9OVaJpztE0dVcyYIvXkidzjYBFuSUYA8TwB2kELOlvXQl+9iEA
    9Uld9wBIhtkuK3MI6emCPyFETpqK3oG8vmnYKB8E52L2lp9tfxdqI5WlUg8DRlsGatcZ
    FpemrrHUINeHGt5x7opkBdDOkX9vzONP74UXJYIN4dkE6ZpzBKhS9OTVsKLAkmUHylDw
    TOeWRKWinDH0T/wBY09+eaocEz3vNrc7URiM4PCTWP0ssrucLyFAlDVc75/4tNoN3sYV
    D9Sg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1677617516;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oz4kY5q/g3qcm+X43NvknJeXnZXMWW1IWtdNSGAt7y8=;
    b=Ho/C3YmgKifhEyC/zILTRWiNS+bV/gtMCrxnpBY1N5KpYTzOFbNBFfjflsl/yiPU8N
    mmd2J5d647Ers6WEx90WxyvanmA+WuygoSe16Qmx0tQegl4VexXLEFjjpb4xr/P+3JTR
    5O6PdkypgbQ+ZTku/YQ43sNs9xhlhqQdLSSiGh/QvzCL3gfb6CzHf5qF+q37CjCuqF3d
    FokQGn71F9ZpAl1IN8dN1vYbPRzZS2jicbQEB4rWeq5mqYMcHBYC2qjHrK2GxKGsCJyU
    I0ks3EAXZSjjqdddUZRnA5KGXE1muF0Wt+zeDsaV3iZVNzTI4lQALUFXOFSzqBufi+no
    ksJQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id c675b3z1SKpu1Cs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 28 Feb 2023 21:51:56 +0100 (CET)
Message-ID: <bde22911-b7ef-56b0-8f33-07f33fa4884e@hartkopp.net>
Date:   Tue, 28 Feb 2023 21:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: please re-send [RFC PATCH] can: isotp: fix poll() to not report
 false positive EPOLLOUT events
Content-Language: en-US
To:     Michal Sojka <michal.sojka@cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <878rghtt0p.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 28.02.23 21:49, Michal Sojka wrote:

>> Can you please re-send your patch, so that I can comment inside?
> 
> resending in a minute.

No hurry! I think I'm done for today anyway :-D

Best regards,
Oliver
