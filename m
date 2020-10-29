Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E429EC48
	for <lists+linux-can@lfdr.de>; Thu, 29 Oct 2020 13:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJ2Mui (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Oct 2020 08:50:38 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:8897 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2Mui (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Oct 2020 08:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603975836;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GcHUJfei2GHynRT17Eet1qyKbECdbytUxM+xcX/GzT0=;
        b=HmZ3pjwcke/8JwJP85N0WzJhkwM7gACFbkN33leN7BjGjZorrlLggqCnlfcQUgOsWh
        6+uRgLSilEAiPKFi2Q3lDdtpIIdh8BHDr+vAu9lZEmzIB54QDpYrskvg3B45EZmRFbJb
        omIjCM4Ob9HA80YbBO5xwj0qyfKx1DH/tSzbljq6/3s67uXkBszTPhlvYuJuiOXVppQp
        E0uYhbBgIP0fUCMCnCgDANRgOEkBCb4RqZBPGLnWbLdTETsJZXe2f4+pcf49hbb9lk1E
        eWPqV3OzmbnV7yAwtZFAa8TM8iHt3g/mpU8cMccFnOIEyXszrzmNNHBVuHoz5XJkec0U
        lfoQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOM1ppw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bew9TCoY1kA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 29 Oct 2020 13:50:34 +0100 (CET)
Subject: Re: [PATCH testing-only] can-dev: implement len8_dlc in some CAN USB
 adapters for testing
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201029083258.41569-1-socketcan@hartkopp.net>
 <d58008e9-3e07-73b4-27bb-ac5eeebacc0f@hartkopp.net>
 <8818b66d-a986-fb7a-b80b-985ec0d750f5@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7a370719-09d0-0191-7d46-6932cebee746@hartkopp.net>
Date:   Thu, 29 Oct 2020 13:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8818b66d-a986-fb7a-b80b-985ec0d750f5@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 29.10.20 10:56, Marc Kleine-Budde wrote:
> On 10/29/20 10:50 AM, Oliver Hartkopp wrote:
>> Info: usb8dev and gs_usb work as expected.
> 
> Which gs_usb are you using? The original one, or the candelight?

The "original candelight" from Hubert :-)

Best,
Oliver
