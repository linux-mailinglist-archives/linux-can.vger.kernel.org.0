Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10F02D93D6
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 09:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439078AbgLNINH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 03:13:07 -0500
Received: from first.geanix.com ([116.203.34.67]:57758 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439074AbgLNINB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 14 Dec 2020 03:13:01 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 5707C481A89;
        Mon, 14 Dec 2020 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1607933537; bh=RYM5oS08/h8SEh5FcFmIZjDoa2nmgwQULWW/QSarT0w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W3AhMdbu4gkqNEdqPXET9XEsMM86pwgh4DiueFaKGiJ8PXBUACe2vocSfmyG0uFyn
         ldWtan1L3O1tjhdY1MuRkih5eVq4brnzIXuJ2L8NUSfqlQoJTLDy/tqqkN8xoiasE1
         DBBiiBQWbFHfaIO4fB8uHkr5NJTiujwVwVx3YzZfWxQ7fBnawMKLixQJToVQJJoY0Z
         46xNxZ24sQw9ZCOCmnKdBWvVPXhPU6nUbNh4TQP3+MKpoL1IHMTfLGPj3M8RUMHNGh
         fENXZ2aIZbYbMMDs5fpIwe6914YkFO/Lx8OXOZ8cktlsKe+0yEDoWlVMiIjaVVsmK9
         EQpG0p74oUjaQ==
Subject: Re: [can-next-rfc 3/7] can: m_can: use cdev as name for struct
 m_can_classdev uniformly
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-4-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <7454be99-d576-1912-a186-526396216bb7@geanix.com>
Date:   Mon, 14 Dec 2020 09:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201212175518.139651-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12/12/2020 18.55, Marc Kleine-Budde wrote:
> This patch coverts the m_can driver to use cdev as name for struct
> m_can_classdev uniformly throughout the whole driver.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/m_can.c | 98 +++++++++++++++++------------------
>   1 file changed, 49 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 27e736464580..fb408ca85188 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1327,79 +1327,79 @@ static bool m_can_niso_supported(struct m_can_classdev *cdev)
>   	return !niso_timeout;
>   }
>   
> -static int m_can_dev_setup(struct m_can_classdev *m_can_dev)
> +static int m_can_dev_setup(struct m_can_classdev *cdev)
>   {
> -	struct net_device *dev = m_can_dev->net;
> +	struct net_device *dev = cdev->net;
>   	int m_can_version;
>   
> -	m_can_version = m_can_check_core_release(m_can_dev);
> +	m_can_version = m_can_check_core_release(cdev);
>   	/* return if unsupported version */
>   	if (!m_can_version) {
> -		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
> +		dev_err(cdev->dev, "Unsupported version number: %2d",
>   			m_can_version);
>   		return -EINVAL;
>   	}
>   
> -	if (!m_can_dev->is_peripheral)
> -		netif_napi_add(dev, &m_can_dev->napi,
> +	if (!cdev->is_peripheral)
> +		netif_napi_add(dev, &cdev->napi,
>   			       m_can_poll, M_CAN_NAPI_WEIGHT);
>   
>   	/* Shared properties of all M_CAN versions */
> -	m_can_dev->version = m_can_version;
> -	m_can_dev->can.do_set_mode = m_can_set_mode;
> -	m_can_dev->can.do_get_berr_counter = m_can_get_berr_counter;
> +	cdev->version = m_can_version;
> +	cdev->can.do_set_mode = m_can_set_mode;
> +	cdev->can.do_get_berr_counter = m_can_get_berr_counter;
>   
>   	/* Set M_CAN supported operations */
> -	m_can_dev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> +	cdev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>   		CAN_CTRLMODE_LISTENONLY |
>   		CAN_CTRLMODE_BERR_REPORTING |
>   		CAN_CTRLMODE_FD |
>   		CAN_CTRLMODE_ONE_SHOT;
>   
>   	/* Set properties depending on M_CAN version */
> -	switch (m_can_dev->version) {
> +	switch (cdev->version) {
>   	case 30:
>   		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
>   		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> -		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> -			m_can_dev->bit_timing : &m_can_bittiming_const_30X;
> +		cdev->can.bittiming_const = cdev->bit_timing ?
> +			cdev->bit_timing : &m_can_bittiming_const_30X;
>   
> -		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> -			m_can_dev->data_timing :
> +		cdev->can.data_bittiming_const = cdev->data_timing ?
> +			cdev->data_timing :
>   			&m_can_data_bittiming_const_30X;
>   		break;
>   	case 31:
>   		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
>   		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> -		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> -			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
> +		cdev->can.bittiming_const = cdev->bit_timing ?
> +			cdev->bit_timing : &m_can_bittiming_const_31X;
>   
> -		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> -			m_can_dev->data_timing :
> +		cdev->can.data_bittiming_const = cdev->data_timing ?
> +			cdev->data_timing :
>   			&m_can_data_bittiming_const_31X;
>   		break;
>   	case 32:
>   	case 33:
>   		/* Support both MCAN version v3.2.x and v3.3.0 */
> -		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> -			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
> +		cdev->can.bittiming_const = cdev->bit_timing ?
> +			cdev->bit_timing : &m_can_bittiming_const_31X;
>   
> -		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> -			m_can_dev->data_timing :
> +		cdev->can.data_bittiming_const = cdev->data_timing ?
> +			cdev->data_timing :
>   			&m_can_data_bittiming_const_31X;
>   
> -		m_can_dev->can.ctrlmode_supported |=
> -			(m_can_niso_supported(m_can_dev) ?
> +		cdev->can.ctrlmode_supported |=
> +			(m_can_niso_supported(cdev) ?
>   			 CAN_CTRLMODE_FD_NON_ISO : 0);
>   		break;
>   	default:
> -		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
> -			m_can_dev->version);
> +		dev_err(cdev->dev, "Unsupported version number: %2d",
> +			cdev->version);
>   		return -EINVAL;
>   	}
>   
> -	if (m_can_dev->ops->init)
> -		m_can_dev->ops->init(m_can_dev);
> +	if (cdev->ops->init)
> +		cdev->ops->init(cdev);
>   
>   	return 0;
>   }
> @@ -1751,15 +1751,15 @@ void m_can_init_ram(struct m_can_classdev *cdev)
>   }
>   EXPORT_SYMBOL_GPL(m_can_init_ram);
>   
> -int m_can_class_get_clocks(struct m_can_classdev *m_can_dev)
> +int m_can_class_get_clocks(struct m_can_classdev *cdev)
>   {
>   	int ret = 0;
>   
> -	m_can_dev->hclk = devm_clk_get(m_can_dev->dev, "hclk");
> -	m_can_dev->cclk = devm_clk_get(m_can_dev->dev, "cclk");
> +	cdev->hclk = devm_clk_get(cdev->dev, "hclk");
> +	cdev->cclk = devm_clk_get(cdev->dev, "cclk");
>   
> -	if (IS_ERR(m_can_dev->cclk)) {
> -		dev_err(m_can_dev->dev, "no clock found\n");
> +	if (IS_ERR(cdev->cclk)) {
> +		dev_err(cdev->dev, "no clock found\n");
>   		ret = -ENODEV;
>   	}
>   
> @@ -1818,49 +1818,49 @@ void m_can_class_free_dev(struct net_device *net)
>   }
>   EXPORT_SYMBOL_GPL(m_can_class_free_dev);
>   
> -int m_can_class_register(struct m_can_classdev *m_can_dev)
> +int m_can_class_register(struct m_can_classdev *cdev)
>   {
>   	int ret;
>   
> -	if (m_can_dev->pm_clock_support) {
> -		ret = m_can_clk_start(m_can_dev);
> +	if (cdev->pm_clock_support) {
> +		ret = m_can_clk_start(cdev);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	ret = m_can_dev_setup(m_can_dev);
> +	ret = m_can_dev_setup(cdev);
>   	if (ret)
>   		goto clk_disable;
>   
> -	ret = register_m_can_dev(m_can_dev->net);
> +	ret = register_m_can_dev(cdev->net);
>   	if (ret) {
> -		dev_err(m_can_dev->dev, "registering %s failed (err=%d)\n",
> -			m_can_dev->net->name, ret);
> +		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
> +			cdev->net->name, ret);
>   		goto clk_disable;
>   	}
>   
> -	devm_can_led_init(m_can_dev->net);
> +	devm_can_led_init(cdev->net);
>   
> -	of_can_transceiver(m_can_dev->net);
> +	of_can_transceiver(cdev->net);
>   
> -	dev_info(m_can_dev->dev, "%s device registered (irq=%d, version=%d)\n",
> -		 KBUILD_MODNAME, m_can_dev->net->irq, m_can_dev->version);
> +	dev_info(cdev->dev, "%s device registered (irq=%d, version=%d)\n",
> +		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
>   
>   	/* Probe finished
>   	 * Stop clocks. They will be reactivated once the M_CAN device is opened
>   	 */
>   clk_disable:
> -	m_can_clk_stop(m_can_dev);
> +	m_can_clk_stop(cdev);
>   
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(m_can_class_register);
>   
> -void m_can_class_unregister(struct m_can_classdev *m_can_dev)
> +void m_can_class_unregister(struct m_can_classdev *cdev)
>   {
> -	unregister_candev(m_can_dev->net);
> +	unregister_candev(cdev->net);
>   
> -	m_can_clk_stop(m_can_dev);
> +	m_can_clk_stop(cdev);
>   }
>   EXPORT_SYMBOL_GPL(m_can_class_unregister);
>   

