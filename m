Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98052D93E0
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 09:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgLNIOY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 03:14:24 -0500
Received: from first.geanix.com ([116.203.34.67]:57842 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439132AbgLNIOV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 14 Dec 2020 03:14:21 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 1BDF6485B36;
        Mon, 14 Dec 2020 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1607933617; bh=tmOk0zl1M9K9Q82g4Eku1Go57kfg+JrDITZZMarfBsw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AyJ5+prHhftfLCpSvfT4nUvxFucJuHMt58kYop1QliP+1aC1LXfV54UL71VygiS+z
         gd0YjWJ9dIHIWltJXLMJPYXb8bOER0Mt4ZJpI4N4uHkomhb7VLlW/cnq8Oyl3UN/+F
         uGYbABAHHgRK4WximSeSQ+LZSnRChT6mnYl2VKGOXOnPrZDXP6aIPCZFEpQn3VOT9e
         2Jz7EpiNozkneJW+5+PfijRHPWoBs6ARDOdZ5Psj8fwECCvegs6CT/pnH5FG66TNqj
         VFb7xS/mg6C/BTt+OLyYXnvLwzBumV+sVkG3+2oupYnjptmUfKfhdu7Ze8wUtSWtuj
         QUS5eqD5rKrKQ==
Subject: Re: [can-next-rfc 7/7] can: m_can: use struct m_can_classdev as
 drvdata
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-8-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <225fe014-d005-f1ce-0a67-25dc84efa5ee@geanix.com>
Date:   Mon, 14 Dec 2020 09:13:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201212175518.139651-8-mkl@pengutronix.de>
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
> The m_can driver's suspend and resume functions (m_can_class_suspend() and
> m_can_class_resume()) make use of dev_get_drvdata() and assume that the drvdata
> is a pointer to the struct net_device.
>
> With upcoming conversion of the tcan4x5x driver to pm_runtime this assumption
> is no longer valid. As the suspend and resume functions actually need a struct
> m_can_classdev pointer, change the m_can_platform and the m_can_pci driver to
> hold a pointer to struct m_can_classdev instead, as the tcan4x5x driver already
> does.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/m_can.c          |  8 ++++----
>   drivers/net/can/m_can/m_can_pci.c      |  5 ++---
>   drivers/net/can/m_can/m_can_platform.c | 14 +++++++-------
>   3 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 46b23fd33f4a..ebf52f1aca10 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1859,8 +1859,8 @@ EXPORT_SYMBOL_GPL(m_can_class_unregister);
>   
>   int m_can_class_suspend(struct device *dev)
>   {
> -	struct net_device *ndev = dev_get_drvdata(dev);
> -	struct m_can_classdev *cdev = netdev_priv(ndev);
> +	struct m_can_classdev *cdev = dev_get_drvdata(dev);
> +	struct net_device *ndev = cdev->net;
>   
>   	if (netif_running(ndev)) {
>   		netif_stop_queue(ndev);
> @@ -1879,8 +1879,8 @@ EXPORT_SYMBOL_GPL(m_can_class_suspend);
>   
>   int m_can_class_resume(struct device *dev)
>   {
> -	struct net_device *ndev = dev_get_drvdata(dev);
> -	struct m_can_classdev *cdev = netdev_priv(ndev);
> +	struct m_can_classdev *cdev = dev_get_drvdata(dev);
> +	struct net_device *ndev = cdev->net;
>   
>   	pinctrl_pm_select_default_state(dev);
>   
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
> index ebfbef25e3f9..128808605c3f 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -115,7 +115,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   	mcan_class->can.clock.freq = id->driver_data;
>   	mcan_class->ops = &m_can_pci_ops;
>   
> -	pci_set_drvdata(pci, mcan_class->net);
> +	pci_set_drvdata(pci, mcan_class);
>   
>   	ret = m_can_class_register(mcan_class);
>   	if (ret)
> @@ -138,8 +138,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   
>   static void m_can_pci_remove(struct pci_dev *pci)
>   {
> -	struct net_device *dev = pci_get_drvdata(pci);
> -	struct m_can_classdev *mcan_class = netdev_priv(dev);
> +	struct m_can_classdev *mcan_class = pci_get_drvdata(pci);
>   	struct m_can_pci_priv *priv = cdev_to_priv(mcan_class);
>   
>   	pm_runtime_forbid(&pci->dev);
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index 5758d25e42c8..599de0e08cd7 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -113,7 +113,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
>   
>   	mcan_class->is_peripheral = false;
>   
> -	platform_set_drvdata(pdev, mcan_class->net);
> +	platform_set_drvdata(pdev, mcan_class);
>   
>   	m_can_init_ram(mcan_class);
>   
> @@ -143,8 +143,8 @@ static __maybe_unused int m_can_resume(struct device *dev)
>   
>   static int m_can_plat_remove(struct platform_device *pdev)
>   {
> -	struct net_device *dev = platform_get_drvdata(pdev);
> -	struct m_can_classdev *mcan_class = netdev_priv(dev);
> +	struct m_can_plat_priv *priv = platform_get_drvdata(pdev);
> +	struct m_can_classdev *mcan_class = &priv->cdev;
>   
>   	m_can_class_unregister(mcan_class);
>   
> @@ -155,8 +155,8 @@ static int m_can_plat_remove(struct platform_device *pdev)
>   
>   static int __maybe_unused m_can_runtime_suspend(struct device *dev)
>   {
> -	struct net_device *ndev = dev_get_drvdata(dev);
> -	struct m_can_classdev *mcan_class = netdev_priv(ndev);
> +	struct m_can_plat_priv *priv = dev_get_drvdata(dev);
> +	struct m_can_classdev *mcan_class = &priv->cdev;
>   
>   	clk_disable_unprepare(mcan_class->cclk);
>   	clk_disable_unprepare(mcan_class->hclk);
> @@ -166,8 +166,8 @@ static int __maybe_unused m_can_runtime_suspend(struct device *dev)
>   
>   static int __maybe_unused m_can_runtime_resume(struct device *dev)
>   {
> -	struct net_device *ndev = dev_get_drvdata(dev);
> -	struct m_can_classdev *mcan_class = netdev_priv(ndev);
> +	struct m_can_plat_priv *priv = dev_get_drvdata(dev);
> +	struct m_can_classdev *mcan_class = &priv->cdev;
>   	int err;
>   
>   	err = clk_prepare_enable(mcan_class->hclk);

