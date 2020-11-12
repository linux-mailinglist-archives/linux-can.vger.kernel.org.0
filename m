Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7896C2AFFA4
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 07:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgKLG2t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 12 Nov 2020 01:28:49 -0500
Received: from mail.tecon.ru ([82.112.190.120]:58495 "EHLO mail.tecon.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKLG2t (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 12 Nov 2020 01:28:49 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2020 01:28:48 EST
From:   =?koi8-r?B?5NXOwcXXIOTNydTSycog7cnIwcrMz9fJ3g==?= <dunaev@tecon.ru>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
CC:     "dunaich@mail.ru" <dunaich@mail.ru>
Subject: Re: [PATCH] fixup! can: mscan: mscan_rx_poll(): fix rx path lockup
 when returning from polling to irq mode
Date:   Thu, 12 Nov 2020 06:13:42 +0000
Message-ID: <31d96954c1824c1a9b825413e18bead9@tecon.ru>
References: <4365eab9aee7f907c5b62fc71a79ccc4c56312fa.camel@tecon.ru>,<deca9362-a911-5bd1-c8f3-1ed25a5d03ca@pengutronix.de>
In-Reply-To: <deca9362-a911-5bd1-c8f3-1ed25a5d03ca@pengutronix.de>
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Good day.


Yes, we using LTE 4.9 so "likely(napi_complete_done())" from higher versions is incompatible with LTE 4.9 and 4.4.

I don't know how to leave it unchanged in LTE mainstream but in our port I will  uplift napi changes from 4.19 kernel to our port.


Thank you for answer! Take care on covid19!


/Dmitry

________________________________
От: Marc Kleine-Budde <mkl@pengutronix.de>
Отправлено: 12 ноября 2020 г. 1:44
Кому: Дунаев Дмитрий Михайлович; linux-can
Копия: dunaich@mail.ru
Тема: Re: [PATCH] fixup! can: mscan: mscan_rx_poll(): fix rx path lockup when returning from polling to irq mode

On 7/30/20 10:40 AM, Dmitry Dunaev wrote:
> can: mscan: mscan_rx_poll(): fix void function return result check
>
> Last operation in mscan_rx_poll() check result of calling napi_complete_done()
> function which has void type. So some compilers (like riscv32-unknown-linux-gnu-gcc)
> raises error on this line.

Since commit:

    364b6055738b net: busy-poll:
                 return busypolling status to drivers

the function napi_complete_done() is bool, that was in v4.10-rc1~202^2~255^2~2.

> According to 'likely' compiler option and network api usage this check is removed.
>
> Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
> ---
>  drivers/net/can/mscan/mscan.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
> index 99101d7027a8..e06ae5888358 100644
> --- a/drivers/net/can/mscan/mscan.c
> +++ b/drivers/net/can/mscan/mscan.c
> @@ -412,11 +412,10 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
>          }
>
>          if (work_done < quota) {
> -               if (likely(napi_complete_done(&priv->napi, work_done))) {

This "likely(napi_complete_done())" was introduced in:

    2d77bd61a292 can: mscan: mscan_rx_poll():
    fix rx path lockup when returning from polling to irq mode

which is v5.5-rc6~23^2~35^2.

Are you using a kernel older than v4.10?

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

