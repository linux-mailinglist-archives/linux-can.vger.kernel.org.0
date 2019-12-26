Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841A012AD68
	for <lists+linux-can@lfdr.de>; Thu, 26 Dec 2019 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLZQNk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Dec 2019 11:13:40 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:22572 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfLZQNk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Dec 2019 11:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577376815;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ueXytAtGjKQkyYxxBK1MdDrUTgUnMu5M0Hd94Hy6ypI=;
        b=JkM3izOzDwgduq+DiJIQqf/60koGgzKigP4Uj2aBgvmB1S/4VzVWTV7YLJDQUEpxjv
        uHfT2WOxJDL2Z1REcwJjoNhbQA1kff/6hVXkZDhN5AZyH+gJijohmZfPaA6RxdLpCX9w
        voxCF06L2DnaJtorQfqrwmcUa7AACWXuw8DKmY2ETKB0v13zUwY3Uj5uoeEiCqK6Bo8/
        Q9wqDNQsOiH1pRKdPyVUHOazkY0rkntFSjfmgClwPgPEoIZjBfeADbT088PJBB4xlb4H
        +OQUYti+kB1Q393rjCJJH3KupnrweEdyeiZ6CQU/qr4ccaxTg29W6OlDxMhC7Qp2dqZj
        CK4g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUMh6kU4f"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.121]
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id n05b53vBQGDX42j
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 26 Dec 2019 17:13:33 +0100 (CET)
Subject: Re: [PATCH v3] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20191210103130.11201-1-mkl@pengutronix.de>
 <ea12de3d-e258-f4a7-6219-71995dbe8134@hartkopp.net>
 <202358df-df7b-b999-b820-33006ba0b264@hartkopp.net>
 <8992a653-11e7-b907-3dfe-2d7c3d33bf89@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <86c957f5-77d1-7b0a-c4b1-2fe77d0a8eb1@hartkopp.net>
Date:   Thu, 26 Dec 2019 17:13:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <8992a653-11e7-b907-3dfe-2d7c3d33bf89@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12/19/19 10:24 AM, Marc Kleine-Budde wrote:
> On 12/16/19 7:03 PM, Oliver Hartkopp wrote:
>>> When do you want to push it upstream?
> 
> I'm on Holidays now, so probably at the Congress.

/me too.
Looking forward to meet you there :-)

CU

Oliver

