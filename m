Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA9FDC0D
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2019 12:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKOLPF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Nov 2019 06:15:05 -0500
Received: from first.geanix.com ([116.203.34.67]:43864 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfKOLPF (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 15 Nov 2019 06:15:05 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id E3D5590514;
        Fri, 15 Nov 2019 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1573816332; bh=vyiJM95QdqpnGZWHOo149H8Q30NJEv7WI//WFhpndas=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=XLY6xLv0smkATPsQQFXbUTcmWg/NWA9cJhKJybEFSkCMpS+BrnFyid+GtznevbPSe
         YxMYonX0Dv0vU/GUjfuxO2QIvLwEqEgkC6GdgXvDjmB/F0mncpqnYhCBcWQppgV+lT
         NAKPSYoMrTDieP7aNFM0FTVPFqwLGJj19M5teJsbufj2fi+k8mc9xrnzVAEwuxcs5O
         0WlUOG/31zjiESamupFSkeKv7D9mSrNkQr74QMFaj4CoY/GElKEk3NaGmuE3gQMjCi
         zmkTT2pu26A2c/07esFY6gYpyjyicS+9CuEPjrurn9l79HYtKdykfJy3+DNxJJhiYp
         O2hbE+KpSphAw==
Subject: Re: CAN bitrate and settings readout
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        dev.kurt@vandijck-laurijssen.be
References: <74972b2d-4580-f3da-b01c-c685680a00ec@geanix.com>
 <20191115110822.GA19412@x1.vandijck-laurijssen.be>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <9225f983-f8a2-3cc8-706d-d49fc1533424@geanix.com>
Date:   Fri, 15 Nov 2019 12:14:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191115110822.GA19412@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15/11/2019 12.08, Kurt Van Dijck wrote:

> $ ip -d link show can0


Thanks :-)

/Sean
