Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F311166E9
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 07:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfLIG3J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 01:29:09 -0500
Received: from first.geanix.com ([116.203.34.67]:34682 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfLIG3J (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 01:29:09 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id BC278407;
        Mon,  9 Dec 2019 06:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575872928; bh=WYbCZWCDszpoGBIPMZ+bnl+EtDs5n/g2APcdXBg+XuQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Xalk82+AqE2Ro7P7PTowgzlJOerfwceYx2yI5PnkJLDI+XrmGbNy/f193kOcAdJ8/
         JdYoS2OPP1BGz8/yxPpKAGnvMrLl0bLFzxQV9lYnBRcVDLNg1/JxoobaXZO3zhfdGL
         77Y7RPdPkaHazVGshTGIO2vA5VAaF0t+CBOUJnaDH0TUTgvtBikp2VmHsI8qzW2Yro
         TQWoq6VP7I55emz/LQxOQS02KUUzsfprCcq8rVano1p00dkMO3FcLERA5UcniDd6CC
         vnzaTKVph488/SUUEpdEFh0xU8kwkeHKb+hPHrqy1MA+nT4n2x/q9YB0BuOCf0q9y/
         SX+dDRlz8tjmw==
Subject: Re: [PATCH 1/2] net: m_can: tcan4x5x: add required delay after reset
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20191206152923.470980-1-sean@geanix.com>
 <6f0a5077-360c-39a2-0103-fb91355bcc88@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <1e40506f-7dd9-5d49-25c0-b264ee5caff8@geanix.com>
Date:   Mon, 9 Dec 2019 07:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <6f0a5077-360c-39a2-0103-fb91355bcc88@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 07/12/2019 14.03, Marc Kleine-Budde wrote:
> applied both to linux-can.
Hi Marc

When you write applied to linux-can where can i find it?

I have checked:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git

:-)

/Sean
