Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4502A212F
	for <lists+linux-can@lfdr.de>; Sun,  1 Nov 2020 20:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgKAT65 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Nov 2020 14:58:57 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:19705 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgKAT65 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 14:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604260732;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=O7mRE0Pcq84M2cULvB3ob3aUyqxSwrwa2ASu1vf5E2E=;
        b=TruN89BPSg+IoY+vVAmMJkIzxXVGbN+mwFrO82JBfji/RU6l/kxcrAp2SM01yxkX9z
        j6aMJ7v+jzDdvWbLbyF/F6HHSSUffEkESpnwpA9wRR0MW/kaLZWdIG7ThbqWlNiMfpf0
        nPCsYblr572Av/unQ0gp8DRKeP6m2Ci6+rG3jlDtX4TrQQFCglNOWvMZqZ76QPoiEAt7
        Fz6sxnJijfyKuGSK1bkJWp1UKSpb5N6zumneJST+KVP/Ot2Stfho0O1YHi4xOrG5c7zb
        4qe1y5Mi/3b/b7yOGxIHVwx+kOTEpZEuhAy152WA3yXCoW3Gj1i1IpWrfPCLotjt01W7
        LSCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J8ttpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA1Jwp8k5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 1 Nov 2020 20:58:51 +0100 (CET)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
 <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net>
 <6bfdc3db-5aaf-b492-dc24-fb5d73cd3b23@hartkopp.net>
 <CAMZ6Rq+UY6SJxDJ15jx1vmSFUk9YHWx+Rf5dZiC9OY+6RO9QXg@mail.gmail.com>
 <e2e5e78e-5de8-9a36-ae6c-191518b3bba3@hartkopp.net>
Message-ID: <729dcd89-d4b2-1139-4229-9d88f1fd3175@hartkopp.net>
Date:   Sun, 1 Nov 2020 20:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e2e5e78e-5de8-9a36-ae6c-191518b3bba3@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 01.11.20 17:12, Oliver Hartkopp wrote:

> Yes. After you shared your thoughts I would indeed tend to provide an 
> option '-8' and then always print the raw DLC in parenthesis e.g. (0) or 
> (F).
> 
> IMO this len8_dlc stuff is an expert feature that normal users do not 
> care about. Therefore it should be disabled by default.

I implemented '-8' for your testing with curly braces {} which just 
looks 'more unusual' than ().

Please give it a try also from a visual standpoint if it fits for you.

Best,
Oliver
