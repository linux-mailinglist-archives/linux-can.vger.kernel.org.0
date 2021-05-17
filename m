Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDCA383A90
	for <lists+linux-can@lfdr.de>; Mon, 17 May 2021 18:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhEQQ4o (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 May 2021 12:56:44 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:25261 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhEQQ4l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 May 2021 12:56:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621270520; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oIVOuGf0HHAFX30XSXgrnQ5sfh7+/8xGY0YIU9uUghoVc7a+4HBnDbQr9/0nL5Xbrg
    ZhtPB7KwA+sn1jjlsfeTxN5bNgVJBJ1hyfln2jjHVGJ7li8yd1zYgzNc+obKCqQrlFRu
    a9+BF58hHhixZkZO3tqDjTyGY5n2s7o4izvqDG/qcm1xuf9PD5Yez36SalbmfiKoV4MY
    T/T+usA/25gENPSgUHEO8bAVVE8zjoYyTQALQJ3T64HO0gYCSab1pkXnEFiiK8rGSa8z
    rCMbJBIG6Rgz9l1wWtyeyutJ7xEY2QrlErtAo2yGYziuGPMqDyNKXSxvtScf7v+bH7SP
    qgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621270520;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=NabIg27hBQP8OauwBKlSt921wSU2eRyowy6p/hmApcg=;
    b=CmF8eb4JH+zTj2qhp2uW2te9YBNlYLotM1URy/36Xn3B4aX6yevX9bGFsWUksvICPn
    r9o+0/wpq+CTvA4+D5GYEmNPmGtM8WBur13oQnOpXLgE7QHwJoVI79ds9+qHEBeyRSTy
    MEl1bwiup5WGZQsF61ZxgvIXUS5bkm7MKPvHImuEWjvQlE6Ytc3ozDLwqaVKIVLb8M5C
    tk88celw8k0L6oH8DeyPm/mVDNmKwxVIevnPzxljEeSkYc1f83nmgI09l+oaetRWxPC2
    SVt7o5zPTyLpCsOpTcqYxEgsqBNtbk1c5MpENgBo6wv6BHJpJW3jKztjOANLNusJFQSV
    6gqA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621270520;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=NabIg27hBQP8OauwBKlSt921wSU2eRyowy6p/hmApcg=;
    b=t1oRZsv2+hlRm0PBFGkKHAR1cVES/Cqi30ATWVKfu6axpqQBRE786Vlj6hGy0lTsVG
    omJ7zbhinglzGo518Fn4+1BGGt5mBmQWw6IT6ioLCdlhwCwyp1YRrUj/drPV2wv6GFEV
    ZhuZU63zbKOMeOLt1rkJ+dkDcujC4G3E4qxfW17nGfsNmsjYMcNSXOm0iEzlzL8mJIgz
    DdhcCaea/OIwp98WhFCXYBLD/sbgwWr51q19Fd9sg7uCMjw6sePxINtTdjlo2a/0qiAV
    MECicecYlQ536CY39Dket8r8Pek88BjA8yshm/Tl3kz7zOcUmdw36zi0ZEIK3LYDACxG
    E+wQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKOdeTTL8O"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id m047d1x4HGtK0He
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 18:55:20 +0200 (CEST)
Subject: Re: [PATCH] can: uapi: update CAN-FD frame description
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Ayoub Kaanich <kayoub5@live.com>
References: <20210517113727.77597-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a5c63d9d-2201-fa3a-ec9d-a78828e26189@hartkopp.net>
Date:   Mon, 17 May 2021 18:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210517113727.77597-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 17.05.21 13:37, Marc Kleine-Budde wrote:
> Since an early version of the CAN-FD specification the bit that
> defines a CAN-FD frame on the wire, has been renamed from Extended
> Data Length (EDL) to FD Frame (FDF).
> 
> To avoid confusion, update the struct canfd_frame description in the
> UAPI headers accordingly.
> 
> Suggested-by: Ayoub Kaanich <kayoub5@live.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thanks Marc!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>   include/uapi/linux/can.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index c7535352fef6..ac5d7a31671f 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -123,8 +123,8 @@ struct can_frame {
>   /*
>    * defined bits for canfd_frame.flags
>    *
> - * The use of struct canfd_frame implies the Extended Data Length (EDL) bit to
> - * be set in the CAN frame bitstream on the wire. The EDL bit switch turns
> + * The use of struct canfd_frame implies the FD Frame (FDF) bit to
> + * be set in the CAN frame bitstream on the wire. The FDF bit switch turns
>    * the CAN controllers bitstream processor into the CAN FD mode which creates
>    * two new options within the CAN FD frame specification:
>    *
> 
